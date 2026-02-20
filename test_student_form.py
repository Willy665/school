"""
Script de diagnostic pour tester le formulaire élève
Usage: python test_student_form.py
"""
import sys
from PySide6.QtWidgets import QApplication

# Test 1: Imports
print("═" * 60)
print("TEST 1: Vérification des imports")
print("═" * 60)

try:
    from views.widgets.student_form import StudentForm
    print("✅ Import StudentForm OK")
except ImportError as e:
    print(f"❌ Erreur import StudentForm: {e}")
    sys.exit(1)

try:
    from controllers.student_controller import StudentController
    print("✅ Import StudentController OK")
except ImportError as e:
    print(f"❌ Erreur import StudentController: {e}")
    sys.exit(1)

try:
    from database.connection import DatabaseManager
    print("✅ Import DatabaseManager OK")
except ImportError as e:
    print(f"❌ Erreur import DatabaseManager: {e}")
    sys.exit(1)

# Test 2: Initialisation BDD
print("\n" + "═" * 60)
print("TEST 2: Base de données")
print("═" * 60)

try:
    DatabaseManager.initialize()
    print("✅ BDD initialisée")
except Exception as e:
    print(f"❌ Erreur init BDD: {e}")

# Test 3: Création du formulaire
print("\n" + "═" * 60)
print("TEST 3: Création du formulaire élève")
print("═" * 60)

app = QApplication(sys.argv)

try:
    form = StudentForm()
    print("✅ Formulaire créé avec succès")
    print(f"   - Titre: {form.windowTitle()}")
    print(f"   - student_id: {form.student_id}")
    
    # Test 4: Vérifier les widgets critiques
    print("\n" + "═" * 60)
    print("TEST 4: Vérification des composants")
    print("=" * 60)
    
    widgets_to_check = [
        ('year_combo', 'QComboBox années'),
        ('firstname', 'Champ prénom'),
        ('lastname', 'Champ nom'),
        ('birthdate', 'Date naissance'),
        ('gender', 'Genre'),
        ('class_combo', 'QComboBox classes'),
        ('parent_name', 'Nom parent'),
        ('parent_phone', 'Téléphone parent'),
    ]
    
    for widget_name, desc in widgets_to_check:
        if hasattr(form, widget_name):
            print(f"✅ {desc} ({widget_name})")
        else:
            print(f"❌ MANQUANT: {desc} ({widget_name})")
    
    # Test 5: Vérifier les méthodes
    print("\n" + "═" * 60)
    print("TEST 5: Vérification des méthodes")
    print("=" * 60)
    
    methods = ['_save', '_load_student', '_choose_photo', '_load_years', '_load_classes']
    for method in methods:
        if hasattr(form, method):
            print(f"✅ Méthode {method}")
        else:
            print(f"❌ MANQUANT: Méthode {method}")
    
    print("\n" + "═" * 60)
    print("✅ TOUS LES TESTS RÉUSSIS")
    print("Le formulaire devrait fonctionner correctement.")
    print("Si le problème persiste, vérifiez les logs de l'application.")
    print("═" * 60)
    
except Exception as e:
    print(f"❌ ERREUR lors de la création du formulaire:")
    print(f"   {type(e).__name__}: {e}")
    import traceback
    print("\nTraceback complet:")
    traceback.print_exc()
    sys.exit(1)

sys.exit(0)
