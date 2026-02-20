-- Migration Base de Données v2 → v3
-- À exécuter UNIQUEMENT si vous aviez déjà une base v2

-- 1. Ajouter colonne is_active à school_settings
ALTER TABLE school_settings ADD COLUMN is_active BOOLEAN DEFAULT 0 NOT NULL;

-- 2. Marquer la première école comme active
UPDATE school_settings 
SET is_active = 1 
WHERE id = (SELECT MIN(id) FROM school_settings);

-- 3. Ajouter colonne photo_path aux utilisateurs
ALTER TABLE users ADD COLUMN photo_path VARCHAR(255);

-- 4. Vérification
SELECT 
    'school_settings' as table_name,
    COUNT(*) as total,
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_count
FROM school_settings
UNION ALL
SELECT 
    'users' as table_name,
    COUNT(*) as total,
    SUM(CASE WHEN photo_path IS NOT NULL THEN 1 ELSE 0 END) as with_photo
FROM users;
