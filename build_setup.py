"""
Script de build — GestionScolaire.exe
Usage: python build_setup.py
"""
import sys, os, shutil, subprocess
from pathlib import Path

APP_NAME     = "GestionScolaire"
APP_VERSION  = "1.0.0"
COMPANY_NAME = "Madagascar Education"
MAIN_FILE    = "main.py"
ICON_FILE    = "assets/icon.ico"


def clean():
    print("🧹 Nettoyage…")
    for d in ["dist", "build"]:
        if Path(d).exists():
            shutil.rmtree(d); print(f"   Supprimé: {d}")
    for f in Path(".").glob("*.spec"):
        f.unlink(); print(f"   Supprimé: {f}")


def check_deps():
    print("📦 Vérification dépendances…")
    pkgs = ["pyinstaller","PySide6","sqlalchemy","bcrypt","reportlab","openpyxl","schedule"]
    missing = []
    for p in pkgs:
        try:
            __import__(p.lower())
            print(f"   ✅ {p}")
        except ImportError:
            print(f"   ❌ {p}"); missing.append(p)
    if missing:
        print(f"\n❌ Manquants: {', '.join(missing)}")
        print(f"pip install {' '.join(missing)}")
        return False
    return True


def build():
    print("\n🔨 Build PyInstaller…\n")
    icon = ICON_FILE if Path(ICON_FILE).exists() else None
    args = [
        "pyinstaller",
        "--name", APP_NAME,
        "--onefile",
        "--windowed",
        "--clean",
        "--add-data", "config.py;.",
        "--add-data", "database;database",
        "--add-data", "views;views",
        "--add-data", "controllers;controllers",
        "--add-data", "utils;utils",
        "--hidden-import", "PySide6.QtCore",
        "--hidden-import", "PySide6.QtGui",
        "--hidden-import", "PySide6.QtWidgets",
        "--hidden-import", "sqlalchemy.sql.default_comparator",
        "--hidden-import", "bcrypt",
        "--hidden-import", "reportlab.pdfgen.canvas",
        "--hidden-import", "openpyxl",
        "--hidden-import", "schedule",
        "--collect-all", "PySide6",
        "--collect-all", "sqlalchemy",
        "--collect-all", "reportlab",
        "--noupx",
        MAIN_FILE,
    ]
    if icon:
        args += ["--icon", icon]
    result = subprocess.run(args, capture_output=True, text=True)
    print(result.stdout)
    if result.returncode != 0:
        print(result.stderr); return False
    return True


def package():
    print("\n📦 Création du package…")
    pkg_dir = Path("installer"); pkg_dir.mkdir(exist_ok=True)
    exe = Path("dist") / f"{APP_NAME}.exe"
    if exe.exists():
        shutil.copy2(exe, pkg_dir / f"{APP_NAME}.exe")
        print(f"   ✅ {pkg_dir/APP_NAME}.exe")
    # ZIP portable
    import zipfile
    zip_path = pkg_dir / f"{APP_NAME}_Portable_v{APP_VERSION}.zip"
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        if exe.exists():
            zf.write(pkg_dir / f"{APP_NAME}.exe", f"{APP_NAME}/{APP_NAME}.exe")
    print(f"   ✅ {zip_path.name} ({zip_path.stat().st_size/1024/1024:.2f} MB)")
    # README
    (pkg_dir / "README.txt").write_text(
        f"{APP_NAME} v{APP_VERSION}\n\nLogin: admin / Admin@2025\n", encoding="utf-8")
    print("\n✅ Package prêt dans installer/")


def main():
    print("=" * 55)
    print(f"🚀 BUILD — {APP_NAME} v{APP_VERSION}")
    print("=" * 55 + "\n")
    if not check_deps(): return False
    clean()
    if not build(): print("\n❌ Build échoué"); return False
    package()
    print("\n" + "=" * 55)
    print("✅ BUILD TERMINÉ!")
    print("=" * 55)
    print(f"\nExécutable: dist/{APP_NAME}.exe")
    print(f"Package: installer/{APP_NAME}_Portable_v{APP_VERSION}.zip")
    return True


if __name__ == "__main__":
    sys.exit(0 if main() else 1)
