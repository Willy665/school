BEGIN TRANSACTION;
CREATE TABLE activity_logs (
	id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	action VARCHAR(100) NOT NULL, 
	entity_type VARCHAR(50) NOT NULL, 
	entity_id INTEGER, 
	description TEXT NOT NULL, 
	ip_address VARCHAR(45), 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES users (id)
);
INSERT INTO "activity_logs" VALUES(1,1,'LOGIN','User',1,'Connexion de Administrateur Principal',NULL,'2026-02-18 10:57:51.128181');
INSERT INTO "activity_logs" VALUES(2,1,'LOGIN','User',1,'Connexion de Administrateur Principal',NULL,'2026-02-18 17:42:42.981712');
INSERT INTO "activity_logs" VALUES(3,1,'CREATE','User',2,'Création utilisateur Rajary [DIRECTEUR]',NULL,'2026-02-18 17:44:16.080850');
INSERT INTO "activity_logs" VALUES(4,1,'LOGOUT','User',1,'Déconnexion de Administrateur Principal',NULL,'2026-02-18 17:44:32.762207');
INSERT INTO "activity_logs" VALUES(5,2,'LOGIN','User',2,'Connexion de rajarison willy noe',NULL,'2026-02-18 17:44:48.101055');
INSERT INTO "activity_logs" VALUES(6,2,'LOGOUT','User',2,'Déconnexion de rajarison willy noe',NULL,'2026-02-18 17:46:40.326109');
INSERT INTO "activity_logs" VALUES(7,1,'LOGIN','User',1,'Connexion de Administrateur Principal',NULL,'2026-02-18 17:46:56.227077');
INSERT INTO "activity_logs" VALUES(8,1,'LOGOUT','User',1,'Déconnexion de Administrateur Principal',NULL,'2026-02-18 17:47:41.987250');
INSERT INTO "activity_logs" VALUES(9,2,'LOGIN','User',2,'Connexion de rajarison willy noe',NULL,'2026-02-18 17:47:52.643716');
INSERT INTO "activity_logs" VALUES(10,2,'CREATE','Teacher',1,'Création professeur MARTIN RAKOTO',NULL,'2026-02-18 17:50:49.797410');
INSERT INTO "activity_logs" VALUES(11,2,'CREATE','User',3,'Création utilisateur Mamy [SECRETAIRE]',NULL,'2026-02-18 17:52:46.891970');
INSERT INTO "activity_logs" VALUES(12,2,'LOGOUT','User',2,'Déconnexion de rajarison willy noe',NULL,'2026-02-18 17:52:58.370417');
INSERT INTO "activity_logs" VALUES(13,3,'LOGIN','User',3,'Connexion de rakoto maminiaina',NULL,'2026-02-18 17:53:07.896796');
INSERT INTO "activity_logs" VALUES(14,3,'LOGOUT','User',3,'Déconnexion de rakoto maminiaina',NULL,'2026-02-18 17:56:52.358441');
INSERT INTO "activity_logs" VALUES(15,3,'LOGIN','User',3,'Connexion de rakoto maminiaina',NULL,'2026-02-18 18:05:15.623493');
INSERT INTO "activity_logs" VALUES(16,3,'LOGOUT','User',3,'Déconnexion de rakoto maminiaina',NULL,'2026-02-18 18:08:53.634159');
INSERT INTO "activity_logs" VALUES(17,3,'LOGIN','User',3,'Connexion de rakoto maminiaina',NULL,'2026-02-18 18:12:20.141766');
INSERT INTO "activity_logs" VALUES(18,3,'LOGOUT','User',3,'Déconnexion de rakoto maminiaina',NULL,'2026-02-18 18:15:08.132901');
INSERT INTO "activity_logs" VALUES(19,1,'LOGIN','User',1,'Connexion de Administrateur Principal',NULL,'2026-02-19 09:53:20.232555');
CREATE TABLE classes (
	id INTEGER NOT NULL, 
	school_year_id INTEGER NOT NULL, 
	class_name VARCHAR(50) NOT NULL, 
	level VARCHAR(20) NOT NULL, 
	capacity INTEGER, 
	room_number VARCHAR(10), 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(school_year_id) REFERENCES school_years (id)
);
INSERT INTO "classes" VALUES(1,1,'TPS','TPS',34,'','2026-02-18 17:51:38.242486');
CREATE TABLE grades (
	id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	class_id INTEGER NOT NULL, 
	subject_id INTEGER NOT NULL, 
	teacher_id INTEGER NOT NULL, 
	term VARCHAR(20) NOT NULL, 
	grade_value FLOAT NOT NULL, 
	max_grade FLOAT NOT NULL, 
	grade_date DATE NOT NULL, 
	is_validated BOOLEAN NOT NULL, 
	validated_by INTEGER, 
	validated_at DATETIME, 
	entered_by INTEGER NOT NULL, 
	comments TEXT, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	CONSTRAINT check_grade_positive CHECK (grade_value >= 0), 
	CONSTRAINT check_grade_max CHECK (grade_value <= max_grade), 
	FOREIGN KEY(student_id) REFERENCES students (id), 
	FOREIGN KEY(class_id) REFERENCES classes (id), 
	FOREIGN KEY(subject_id) REFERENCES subjects (id), 
	FOREIGN KEY(teacher_id) REFERENCES teachers (id), 
	FOREIGN KEY(validated_by) REFERENCES users (id), 
	FOREIGN KEY(entered_by) REFERENCES users (id)
);
CREATE TABLE payments (
	id INTEGER NOT NULL, 
	school_year_id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	receipt_number VARCHAR(20) NOT NULL, 
	amount FLOAT NOT NULL, 
	payment_date DATE NOT NULL, 
	payment_mode VARCHAR(20) NOT NULL, 
	payment_reference VARCHAR(100), 
	payment_status VARCHAR(7) NOT NULL, 
	description TEXT, 
	recorded_by INTEGER, 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(school_year_id) REFERENCES school_years (id), 
	FOREIGN KEY(student_id) REFERENCES students (id), 
	FOREIGN KEY(recorded_by) REFERENCES users (id)
);
CREATE TABLE report_cards (
	id INTEGER NOT NULL, 
	student_id INTEGER NOT NULL, 
	term VARCHAR(20) NOT NULL, 
	average FLOAT NOT NULL, 
	rank INTEGER, 
	total_students INTEGER, 
	comments TEXT, 
	is_validated BOOLEAN NOT NULL, 
	validated_by INTEGER, 
	validated_at DATETIME, 
	generated_at DATETIME NOT NULL, 
	pdf_path VARCHAR(255), 
	PRIMARY KEY (id), 
	FOREIGN KEY(student_id) REFERENCES students (id), 
	FOREIGN KEY(validated_by) REFERENCES users (id)
);
CREATE TABLE salaries (
	id INTEGER NOT NULL, 
	school_year_id INTEGER NOT NULL, 
	teacher_id INTEGER NOT NULL, 
	payment_number VARCHAR(20) NOT NULL, 
	amount FLOAT NOT NULL, 
	payment_date DATE NOT NULL, 
	payment_mode VARCHAR(20) NOT NULL, 
	payment_reference VARCHAR(100), 
	month VARCHAR(7) NOT NULL, 
	description TEXT, 
	recorded_by INTEGER, 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(school_year_id) REFERENCES school_years (id), 
	FOREIGN KEY(teacher_id) REFERENCES teachers (id), 
	FOREIGN KEY(recorded_by) REFERENCES users (id)
);
CREATE TABLE schedules (
	id INTEGER NOT NULL, 
	class_id INTEGER NOT NULL, 
	subject_id INTEGER NOT NULL, 
	teacher_id INTEGER NOT NULL, 
	day_of_week VARCHAR(10) NOT NULL, 
	start_time VARCHAR(5) NOT NULL, 
	end_time VARCHAR(5) NOT NULL, 
	room_number VARCHAR(10), 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(class_id) REFERENCES classes (id), 
	FOREIGN KEY(subject_id) REFERENCES subjects (id), 
	FOREIGN KEY(teacher_id) REFERENCES teachers (id)
);
CREATE TABLE school_settings (
	id INTEGER NOT NULL, 
	school_name VARCHAR(200) NOT NULL, 
	school_address TEXT, 
	school_phone VARCHAR(20), 
	school_email VARCHAR(100), 
	logo_path VARCHAR(255), 
	internal_regulations TEXT, 
	is_active BOOLEAN NOT NULL, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	UNIQUE (school_name)
);
INSERT INTO "school_settings" VALUES(1,'Mon École','Antananarivo, Madagascar','+261 20 XX XXX XX','contact@ecole.mg',NULL,'Règlement intérieur à définir.',1,'2026-02-18 10:57:20.223549','2026-02-18 10:57:20.239174');
INSERT INTO "school_settings" VALUES(2,'MAHARAVO','Madiotsifafana route de gare','0343967629','willynoerajarison@gmail.com',NULL,'fahatarana
sazy',0,'2026-02-18 17:46:00.463027','2026-02-18 17:46:00.468024');
INSERT INTO "school_settings" VALUES(3,'ESSAI','MADIOTSIFAFANA','0349099988','','d:\projet ecole\Nouveau dossier\school_mgmt_v3\assets\logos\626_RANDRIAMBELOSON SOLO DIMBINIAINA (1).png','',0,'2026-02-19 09:59:28.062965','2026-02-19 09:59:28.063965');
CREATE TABLE school_years (
	id INTEGER NOT NULL, 
	year_name VARCHAR(20) NOT NULL, 
	start_date DATE NOT NULL, 
	end_date DATE NOT NULL, 
	is_active BOOLEAN NOT NULL, 
	is_closed BOOLEAN NOT NULL, 
	created_at DATETIME NOT NULL, 
	closed_at DATETIME, 
	PRIMARY KEY (id), 
	CONSTRAINT check_dates CHECK (end_date > start_date), 
	UNIQUE (year_name)
);
INSERT INTO "school_years" VALUES(1,'2025-2026','2025-09-01','2026-06-30',1,0,'2026-02-18 17:49:21.350486',NULL);
CREATE TABLE students (
	id INTEGER NOT NULL, 
	school_year_id INTEGER NOT NULL, 
	student_number VARCHAR(20) NOT NULL, 
	first_name VARCHAR(50) NOT NULL, 
	last_name VARCHAR(50) NOT NULL, 
	date_of_birth DATE NOT NULL, 
	gender VARCHAR(1) NOT NULL, 
	address TEXT, 
	parent_name VARCHAR(100), 
	parent_phone VARCHAR(20), 
	parent_email VARCHAR(100), 
	class_id INTEGER, 
	photo_path VARCHAR(255), 
	enrollment_date DATE NOT NULL, 
	is_active BOOLEAN NOT NULL, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(school_year_id) REFERENCES school_years (id), 
	FOREIGN KEY(class_id) REFERENCES classes (id)
);
CREATE TABLE subjects (
	id INTEGER NOT NULL, 
	subject_name VARCHAR(100) NOT NULL, 
	subject_code VARCHAR(10) NOT NULL, 
	coefficient INTEGER NOT NULL, 
	description TEXT, 
	created_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (subject_name), 
	UNIQUE (subject_code)
);
INSERT INTO "subjects" VALUES(1,'Mathématiques','MATH',3,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(2,'Français','FR',3,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(3,'Anglais','ANG',2,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(4,'Sciences de la Vie et de la Terre','SVT',2,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(5,'Physique-Chimie','PC',2,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(6,'Histoire-Géographie','HG',2,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(7,'Éducation Physique et Sportive','EPS',1,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(8,'Arts Plastiques','ARTS',1,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(9,'Éducation Civique','EC',1,NULL,'2026-02-18 10:57:20.772891');
INSERT INTO "subjects" VALUES(10,'Malagasy','MLG',2,NULL,'2026-02-18 10:57:20.772891');
CREATE TABLE teachers (
	id INTEGER NOT NULL, 
	school_year_id INTEGER NOT NULL, 
	teacher_number VARCHAR(20) NOT NULL, 
	first_name VARCHAR(50) NOT NULL, 
	last_name VARCHAR(50) NOT NULL, 
	date_of_birth DATE, 
	gender VARCHAR(1), 
	phone VARCHAR(20) NOT NULL, 
	email VARCHAR(100), 
	address TEXT, 
	specialization VARCHAR(100), 
	hire_date DATE NOT NULL, 
	monthly_salary FLOAT NOT NULL, 
	is_active BOOLEAN NOT NULL, 
	photo_path VARCHAR(255), 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(school_year_id) REFERENCES school_years (id)
);
INSERT INTO "teachers" VALUES(1,1,'PROF20250001','MARTIN','RAKOTO',NULL,'M','0345834449','','Antsahatanteraka','MATHEMATIQUE','2026-02-18',300000.0,1,NULL,'2026-02-18 17:50:49.483605','2026-02-18 17:50:49.487602');
CREATE TABLE users (
	id INTEGER NOT NULL, 
	username VARCHAR(50) NOT NULL, 
	password_hash VARCHAR(255) NOT NULL, 
	full_name VARCHAR(100) NOT NULL, 
	role VARCHAR(14) NOT NULL, 
	email VARCHAR(100), 
	phone VARCHAR(20), 
	photo_path VARCHAR(255), 
	is_active BOOLEAN NOT NULL, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME, 
	last_login DATETIME, 
	PRIMARY KEY (id), 
	UNIQUE (email)
);
INSERT INTO "users" VALUES(1,'admin','$2b$12$aV9wjNeKDrtviFGBrQoUOOqFd8cTRhCFoaM3YZts3M/s4JPFDWmdq','Administrateur Principal','ADMINISTRATEUR','admin@school.mg',NULL,NULL,1,'2026-02-18 10:57:20.772891','2026-02-19 09:53:20.232555','2026-02-19 09:53:20.232555');
INSERT INTO "users" VALUES(2,'Rajary','$2b$12$XADTwBc2KF6ypZdDlm/3m.2FZR.0pQ0P4MnMo/gCNQT92UvTQEEoG','rajarison willy noe','DIRECTEUR','willynoerajarison@gmail.com','0343967629',NULL,1,'2026-02-18 17:44:15.808508','2026-02-18 17:47:52.643716','2026-02-18 17:47:52.643716');
INSERT INTO "users" VALUES(3,'Mamy','$2b$12$pjBOyVJvIiVoTJLjAm58WOuuB.R6W.BpuAowXQnvXX/ViCtmdJ6qu','rakoto maminiaina','SECRETAIRE','','0345400988',NULL,1,'2026-02-18 17:52:46.615647','2026-02-18 18:12:20.149805','2026-02-18 18:12:20.141766');
CREATE UNIQUE INDEX ix_users_username ON users (username);
CREATE INDEX ix_users_role ON users (role);
CREATE INDEX ix_classes_school_year_id ON classes (school_year_id);
CREATE INDEX ix_teachers_school_year_id ON teachers (school_year_id);
CREATE UNIQUE INDEX ix_teachers_teacher_number ON teachers (teacher_number);
CREATE INDEX ix_activity_logs_user_id ON activity_logs (user_id);
CREATE INDEX ix_activity_logs_created_at ON activity_logs (created_at);
CREATE UNIQUE INDEX ix_students_student_number ON students (student_number);
CREATE INDEX ix_students_class_id ON students (class_id);
CREATE INDEX ix_students_school_year_id ON students (school_year_id);
CREATE INDEX ix_salaries_school_year_id ON salaries (school_year_id);
CREATE UNIQUE INDEX ix_salaries_payment_number ON salaries (payment_number);
CREATE INDEX ix_salaries_teacher_id ON salaries (teacher_id);
CREATE INDEX ix_schedules_teacher_id ON schedules (teacher_id);
CREATE INDEX ix_schedules_subject_id ON schedules (subject_id);
CREATE INDEX ix_schedules_class_id ON schedules (class_id);
CREATE INDEX ix_payments_student_id ON payments (student_id);
CREATE INDEX ix_payments_school_year_id ON payments (school_year_id);
CREATE UNIQUE INDEX ix_payments_receipt_number ON payments (receipt_number);
CREATE INDEX ix_grades_teacher_id ON grades (teacher_id);
CREATE INDEX ix_grades_class_id ON grades (class_id);
CREATE INDEX ix_grades_subject_id ON grades (subject_id);
CREATE INDEX ix_grades_student_id ON grades (student_id);
CREATE INDEX ix_report_cards_student_id ON report_cards (student_id);
COMMIT;
