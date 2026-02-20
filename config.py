import os
from pathlib import Path

BASE_DIR = Path(__file__).parent
DATABASE_PATH = BASE_DIR / "school_data.db"
BACKUP_DIR = BASE_DIR / "backups"
EXPORTS_DIR = BASE_DIR / "exports"
ASSETS_DIR = BASE_DIR / "assets"

BACKUP_DIR.mkdir(exist_ok=True)
EXPORTS_DIR.mkdir(exist_ok=True)
ASSETS_DIR.mkdir(exist_ok=True)

APP_NAME = "Système de Gestion Scolaire"
APP_VERSION = "1.0.0"
APP_COMPANY = "Madagascar Education"

DATABASE_URL = f"sqlite:///{DATABASE_PATH}"

class UserRole:
    ADMIN = "ADMINISTRATEUR"
    DIRECTOR = "DIRECTEUR"
    SECRETARY = "SECRETAIRE"
    TEACHER = "PROFESSEUR"

PAYMENT_MODES = {
    "cash":   "💵 Espèces",
    "boa":    "🏦 Bank of Africa (BOA)",
    "bni":    "🏦 BNI Madagascar",
    "pamf":   "🏦 Paositra Money Finances (PAMF)",
    "access": "🏦 Access Banque Madagascar",
    "yas":    "📱 Yas Madagascar",
    "airtel": "📱 Airtel Madagascar",
    "orange": "📱 Orange Madagascar",
}

CURRENCY = "Ar"
CURRENCY_FORMAT = "{:,.0f} Ar"

BCRYPT_ROUNDS = 12
SESSION_TIMEOUT = 3600

AUTO_BACKUP_ENABLED = True
BACKUP_RETENTION_DAYS = 30
