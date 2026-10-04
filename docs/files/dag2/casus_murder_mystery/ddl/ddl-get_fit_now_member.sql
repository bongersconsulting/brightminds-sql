-- get_fit_now_member definition
CREATE TABLE get_fit_now_member (
	id TEXT
	, person_id INTEGER
	, name TEXT
	, membership_start_date INTEGER
	, membership_status TEXT
	, FOREIGN KEY (person_id) REFERENCES person(id)
	);
