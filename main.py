"""
Système de Gestion Scolaire — Madagascar
Point d'entrée principal

Usage:
    python main.py

Identifiants par défaut:
    Identifiant: admin
    Mot de passe: Admin@2025
"""

import sys
import logging
from pathlib import Path

# ── Configuration du logging ──────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s — %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler("school_management.log", encoding="utf-8"),
    ]
)
logger = logging.getLogger(__name__)


def main():
    # ── Import Qt ────────────────────────────────────────────────────────────
    try:
        from PySide6.QtWidgets import QApplication, QMessageBox
        from PySide6.QtCore import Qt
    except ImportError as e:
        print(f"❌ PySide6 non installé: {e}")
        print("Installez-le avec: pip install PySide6")
        sys.exit(1)

    app = QApplication(sys.argv)
    app.setApplicationName("Gestion Scolaire Madagascar")
    app.setApplicationVersion("1.0.0")
    app.setOrganizationName("Madagascar Education")

    # ── Initialisation base de données ───────────────────────────────────────
    try:
        from database.init_db import initialize_database
        initialize_database()
        logger.info("✅ Base de données initialisée")
    except Exception as e:
        logger.critical(f"❌ Impossible d'initialiser la base de données: {e}", exc_info=True)
        QMessageBox.critical(None, "Erreur Critique",
            f"Impossible d'initialiser la base de données:\n\n{e}\n\n"
            "Vérifiez que vous avez les droits d'écriture dans le dossier de l'application.")
        sys.exit(1)

    # ── Démarrage du planificateur ───────────────────────────────────────────
    try:
        from utils.scheduler import scheduler
        scheduler.start()
        logger.info("✅ Planificateur de tâches démarré")
    except Exception as e:
        logger.warning(f"⚠️ Planificateur non démarré: {e}")

    # ── Fenêtre de connexion ─────────────────────────────────────────────────
    try:
        from views.login_window import LoginWindow
        from views.main_window import MainWindow

        login = LoginWindow()

        def on_login_success(user):
            logger.info(f"✅ Connexion: {user.full_name} [{user.role.value}]")
            window = MainWindow(user)
            window.show()

        login.login_successful.connect(on_login_success)
        login.show()

        exit_code = app.exec()

    except Exception as e:
        logger.critical(f"❌ Erreur fatale: {e}", exc_info=True)
        QMessageBox.critical(None, "Erreur Fatale",
            f"Une erreur critique s'est produite:\n\n{e}\n\n"
            "Consultez le fichier school_management.log pour plus de détails.")
        exit_code = 1

    finally:
        # ── Nettoyage ─────────────────────────────────────────────────────────
        try:
            from utils.scheduler import scheduler
            scheduler.stop()
        except Exception:
            pass
        try:
            from database.connection import DatabaseManager
            DatabaseManager.close()
        except Exception:
            pass
        logger.info("Application fermée proprement")

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
