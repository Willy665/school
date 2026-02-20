# 🏫 Système de Gestion Scolaire — Madagascar

Application de bureau Python/PySide6 pour la gestion complète d'un établissement scolaire.

## 🚀 Démarrage Rapide

### 1. Installer les dépendances
```bash
pip install -r requirements.txt
```

### 2. Lancer l'application
```bash
python main.py
```

### 3. Se connecter
```
Identifiant : admin
Mot de passe : Admin@2025
```

> ⚠️ Changez le mot de passe administrateur dès le premier lancement !

---

## 📁 Structure du Projet

```
school_management_system/
├── main.py                  # Point d'entrée
├── config.py                # Configuration globale
├── requirements.txt         # Dépendances Python
├── build_setup.py           # Script de build .exe
│
├── database/
│   ├── models.py            # Modèles SQLAlchemy (14 tables)
│   ├── connection.py        # Gestionnaire de connexion
│   └── init_db.py           # Initialisation + données par défaut
│
├── controllers/
│   ├── auth_controller.py   # Authentification & RBAC
│   ├── student_controller.py# CRUD Élèves
│   └── payment_controller.py# CRUD Paiements
│
├── views/
│   ├── login_window.py      # Fenêtre de connexion
│   ├── main_window.py       # Fenêtre principale (menu adaptatif)
│   ├── dashboards.py        # Tableaux de bord par rôle
│   ├── student_management.py# Tableau de gestion des élèves
│   ├── payment_management.py# Tableau de gestion des paiements
│   ├── backup_management.py # Interface de sauvegarde
│   ├── scheduler_settings.py# Configuration tâches auto
│   └── widgets/
│       └── student_form.py  # Formulaires Élève + Paiement
│
├── utils/
│   ├── security.py          # Hachage bcrypt
│   ├── pdf_generator.py     # Génération PDF (reçus, bulletins)
│   ├── excel_exporter.py    # Export Excel
│   ├── backup_manager.py    # Sauvegarde/restauration SQLite
│   └── scheduler.py         # Planificateur de tâches
│
├── assets/                  # Icônes, logos
├── exports/                 # PDF et Excel générés
└── backups/                 # Sauvegardes de la base de données
```

---

## 🗄️ Base de Données

SQLite local (`school_data.db`) — **aucune connexion internet requise**.

**Tables** : User, SchoolYear, Class, Student, Subject, Teacher, Payment,
Salary, Grade, ReportCard, Schedule, ActivityLog, SchoolSettings

---

## 👥 Rôles Utilisateurs

| Rôle | Accès |
|------|-------|
| ADMINISTRATEUR | Complet (configuration, sauvegardes, utilisateurs) |
| DIRECTEUR | Consultation + validation des notes et bulletins |
| SECRETAIRE | Gestion quotidienne (élèves, paiements, bulletins) |
| PROFESSEUR | Saisie des notes, consultation emploi du temps |

---

## 💰 Modes de Paiement

Espèces · BOA · BNI · PAMF · Access Banque · Yas · Airtel · Orange

---

## 🛠️ Technologies

- **Interface** : PySide6 (Qt6)
- **Base de données** : SQLAlchemy + SQLite
- **Sécurité** : bcrypt (12 rounds)
- **PDF** : ReportLab
- **Excel** : OpenPyXL
- **Planificateur** : schedule

---

## 📦 Créer un Exécutable Windows

```bash
python build_setup.py
```

L'exécutable sera généré dans `installer/GestionScolaire.exe`

---

## 📋 Données par Défaut

Au premier lancement, l'application crée automatiquement :
- Compte administrateur (`admin` / `Admin@2025`)
- Paramètres école (à compléter)
- 10 matières : Maths, Français, Anglais, SVT, Physique, Histoire, EPS, Arts, Civique, Malagasy

---

© 2026 Madagascar Education — v1.0.0
