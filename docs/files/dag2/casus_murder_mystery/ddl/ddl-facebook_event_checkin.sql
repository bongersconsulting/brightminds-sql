-- facebook_event_checkin definition
CREATE TABLE facebook_event_checkin (
	person_id INTEGER
	, event_id INTEGER
	, event_name TEXT
	, DATE INTEGER
	, FOREIGN KEY (person_id) REFERENCES person(id)
	);
