
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'course_attributes' AND TABLE_SCHEMA = 'db/development'), 
		' FROM course_attributes');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM course_attributes INTO OUTFILE 
	'/tmp/course_attributes2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'course_attributes_sections' AND TABLE_SCHEMA = 'db/development'), 
		' FROM course_attributes_sections');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM course_attributes_sections INTO OUTFILE 
	'/tmp/course_attributes_sections2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'course_numberings' AND TABLE_SCHEMA = 'db/development'), 
		' FROM course_numberings');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM course_numberings INTO OUTFILE 
	'/tmp/course_numberings2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'courses' AND TABLE_SCHEMA = 'db/development'), 
		' FROM courses');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM courses INTO OUTFILE 
	'/tmp/courses2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'instructors' AND TABLE_SCHEMA = 'db/development'), 
		' FROM instructors');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM instructors INTO OUTFILE 
	'/tmp/instructors2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'instructors_sections' AND TABLE_SCHEMA = 'db/development'), 
		' FROM instructors_sections');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM instructors_sections INTO OUTFILE 
	'/tmp/instructors_sections2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'prerequisite_relations' AND TABLE_SCHEMA = 'db/development'), 
		' FROM prerequisite_relations');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM prerequisite_relations INTO OUTFILE 
	'/tmp/prerequisite_relations2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'reviews' AND TABLE_SCHEMA = 'db/development'), 
		' FROM reviews');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM reviews INTO OUTFILE 
	'/tmp/reviews2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'sections' AND TABLE_SCHEMA = 'db/development'), 
		' FROM sections');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM sections INTO OUTFILE 
	'/tmp/sections2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'sessions' AND TABLE_SCHEMA = 'db/development'), 
		' FROM sessions');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM sessions INTO OUTFILE 
	'/tmp/sessions2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'subjects' AND TABLE_SCHEMA = 'db/development'), 
		' FROM subjects');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM subjects INTO OUTFILE 
	'/tmp/subjects2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'time_periods' AND TABLE_SCHEMA = 'db/development'), 
		' FROM time_periods');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM time_periods INTO OUTFILE 
	'/tmp/time_periods2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'time_slots' AND TABLE_SCHEMA = 'db/development'), 
		' FROM time_slots');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM time_slots INTO OUTFILE 
	'/tmp/time_slots2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'users' AND TABLE_SCHEMA = 'db/development'), 
		' FROM users');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	
	SELECT * FROM users INTO OUTFILE 
	'/tmp/users2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"' ESCAPED BY '\\' 
	LINES TERMINATED BY '\n';
	