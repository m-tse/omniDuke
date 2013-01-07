#!/usr/bin/env ruby


dumpCommand = "
	SELECT * FROM %s INTO OUTFILE 
	'/tmp/%s2.csv' FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\\\' 
	LINES TERMINATED BY '\\n';
	"

loadCommand = "
	LOAD DATA INFILE '/tmp/%s2.csv' 
	INTO TABLE %s FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\\\' 
	LINES TERMINATED BY '\\n';
	"

setupCommand = "
	SET @sql = CONCAT('SELECT ', (
		SELECT REPLACE(GROUP_CONCAT(COLUMN_NAME), 
		'id,', '') FROM 
		INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 
		'%s' AND TABLE_SCHEMA = 'db/development'), 
		' FROM %s');
	PREPARE stmt1 FROM @sql;
	EXECUTE stmt1;
	"


File.open("testsql.txt", "r") do |f|
	first = true
	f.each_line do |line|
		if first
			first = false
			next
		end
		puts line
		if line.include? "schema_migrations"
			next
		end
		table = line.delete("\n")
		File.open("dump.sql", "a") do |f|
			f.write(setupCommand % [table, table])
			f.write(dumpCommand % [table, table])
		end
		File.open("load.sql", "a") do |f|
			f.write(loadCommand % [table, table])
		end
	end
end


=begin
command = "mysql --user=root --password= db/development < tables.sql > foo.txt"
=end
