"""
Test minimal du bouton Nouvel Élève
Usage: python test_button.py
"""
import sys
from PySide6.QtWidgets import QApplication, QPushButton, QVBoxLayout, QWidget, QMessageBox

print("=" * 60)
print("TEST BOUTON NOUVEL ÉLÈVE")
print("=" * 60)

# Test 1: Import StudentManagement
print("\n1. Test import StudentManagement...")
try:
    from views.student_management import StudentManagement
    print("   ✅ Import OK")
except ImportError as e:
    print(f"   ❌ Erreur import: {e}")
    sys.exit(1)

# Test 2: Initialiser BDD
print("\n2. Initialisation base de données...")
try:
    from database.init_db import initialize_database
    initialize_database()
    print("   ✅ BDD OK")
except Exception as e:
    print(f"   ❌ Erreur BDD: {e}")

# Test 3: Créer l'app et la page
print("\n3. Création de l'interface...")
app = QApplication(sys.argv)

try:
    page = StudentManagement()
    print("   ✅ StudentManagement créé")
    
    # Test 4: Vérifier que open_add_form existe
    print("\n4. Vérification méthode open_add_form...")
    if hasattr(page, 'open_add_form'):
        print("   ✅ Méthode open_add_form existe")
        
        # Test 5: Appeler directement la méthode
        print("\n5. Test direct de open_add_form()...")
        try:
            page.open_add_form()
            print("   ✅ Méthode appelée sans erreur")
            print("\n" + "=" * 60)
            print("Si vous voyez ce message, le formulaire devrait s'ouvrir.")
            print("Si rien ne s'affiche, c'est un problème dans StudentForm.")
            print("=" * 60)
        except Exception as e:
            print(f"   ❌ ERREUR lors de l'appel: {e}")
            import traceback
            traceback.print_exc()
    else:
        print("   ❌ Méthode open_add_form MANQUANTE!")
    
    # Afficher la page
    page.show()
    
except Exception as e:
    print(f"   ❌ ERREUR: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

sys.exit(app.exec())
