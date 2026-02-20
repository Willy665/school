# 🏫 Gestion Scolaire Madagascar — Version 3

## 🎯 Nouveautés Version 3

### ✨ Interface Utilisateur

#### Menu Principal
- **Police rouge majuscule 12pt** avec **effet 3D** (bordures noir/gris)
- Style distinctif et professionnel

### 🏢 Multi-Écoles

#### Gestion de Plusieurs Établissements
- **NOUVEAU bouton** : Créer plusieurs écoles
- **SUPPRIMER** : Supprimer une école
- **Une seule école active** à la fois
- Logo personnalisé par école
- Tableau de toutes les écoles enregistrées

#### En-Tête Global
- **Logo + Nom + Adresse + Contact** de l'école active
- Affiché automatiquement en haut de **TOUTES les pages**
- Mise à jour dynamique lors du changement d'école

### 👥 Gestion Utilisateurs Améliorée

#### Photos de Profil
- Upload de photo pour chaque utilisateur
- Photo affichée partout (menu, formulaires, listes)
- Stockage dans `assets/user_photos/`

#### Permissions RBAC Strictes

**ADMINISTRATEUR** (accès restreint) :
- Utilisateurs (ajout, consultation, résolution problèmes)
- Paramètres de l'école
- Sauvegardes
- Tâches automatiques

**DIRECTEUR** (accès complet) :
- **TOUS** les menus et fonctionnalités

**SECRÉTAIRE** :
- Années scolaires
- Classes
- Élèves
- Professeurs
- Paiements
- Salaires
- Emploi du temps

**PROFESSEUR** :
- Saisie des notes
- Bulletins
- Emploi du temps
- Gestion des matières

## 📁 Structure Mise à Jour

```
school_mgmt_v3/
├── assets/
│   ├── logos/          # Logos des écoles
│   └── user_photos/    # Photos utilisateurs
├── database/
│   └── models.py       # + is_active, photo_path
├── views/
│   ├── school_config.py  # Multi-écoles + GlobalHeader
│   ├── people_management.py  # Photos utilisateurs
│   └── main_window.py  # Menu rouge 3D + RBAC ajusté
└── controllers/
    └── school_controller.py  # CRUD écoles
```

## 🔑 Identifiants Par Défaut

```
Identifiant : admin
Mot de passe : Admin@2025
```

## 🚀 Installation

```bash
pip install -r requirements.txt
python main.py
```

## 📸 Upload de Fichiers

### Logo École
- Formats : PNG, JPG, JPEG
- Emplacement : `assets/logos/`
- Affichage automatique dans l'en-tête global

### Photo Utilisateur
- Formats : PNG, JPG, JPEG
- Emplacement : `assets/user_photos/`
- Taille recommandée : 200x200px

## 🔄 Migration depuis v2

Si vous aviez déjà une base de données v2 :

```python
# La migration automatique ajoute :
# - SchoolSettings.is_active (Boolean)
# - User.photo_path (String)

# Votre école existante sera marquée comme active
```

## 🎨 Personnalisation

### Style Menu
Modifiable dans `views/main_window.py` :
```python
SIDEBAR_CSS = """
    QPushButton#menuBtn {
        color: #ff0000;        # Rouge
        font-size: 12pt;       # Taille 12
        text-transform: uppercase;
        border: 2px outset #555;  # Effet 3D
    }
"""
```

---

© 2026 Madagascar Education — v3.0.0
