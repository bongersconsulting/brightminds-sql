-- interview definition
CREATE TABLE interview (
	person_id INTEGER
	, transcript TEXT
	, FOREIGN KEY (person_id) REFERENCES person(id)
	);
