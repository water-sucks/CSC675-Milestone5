-- This SQL script will be used to seed the database with some initial values.
-- These will serve as a good jumpstart for querying some real data.

USE `VotingSystemsDB`;

SET @DISABLE_TRIGGERS = 1;

-- Create some cities.
INSERT INTO cities
  (name, city_code, population) VALUES
  ("New York City", "NYC01", 8537673),
  ("Los Angeles", "LA01", 3979576),
  ("Chicago", "CHI01", 2693976),
  ("Houston", "HOU01", 2320268),
  ("Phoenix", "PHX01", 1680992),
  ("Philadelphia", "PHL01", 1584064),
  ("San Antonio", "SA01", 1547253),
  ("San Diego", "SD01", 1425976),
  ("Dallas", "DAL01", 1343573),
  ("San Jose", "SJ01", 1030119),
  ("Austin", "AUS01", 964254),
  ("Jacksonville", "JAX01", 903889),
  ("Fort Worth", "FW01", 895008),
  ("Columbus", "CBUS01", 879170),
  ("San Francisco", "SF01", 870887),
  ("Charlotte", "CLT01", 872498),
  ("Indianapolis", "IND01", 867125),
  ("Seattle", "SEA01", 744955),
  ("Denver", "DEN01", 716492),
  ("Washington", "DC01", 702455),
  ("Boston", "BOS01", 694583),
  ("El Paso", "EP01", 682669),
  ("Detroit", "DET01", 672662),
  ("Nashville", "NAS01", 669053),
  ("Portland", "PDX01", 654741),
  ("Memphis", "MEM01", 646889),
  ("Oklahoma City", "OKC01", 649021),
  ("Las Vegas", "LV01", 641676),
  ("Louisville", "LOU01", 617638),
  ("Baltimore", "BAL01", 593490),
  ("Milwaukee", "MKE01", 587721),
  ("Albuquerque", "ABQ01", 560218),
  ("Tucson", "TUC01", 548073),
  ("Fresno", "FRE01", 530093),
  ("Sacramento", "SAC01", 524943),
  ("Mesa", "MESA01", 518012),
  ("Kansas City", "KC01", 495327),
  ("Atlanta", "ATL01", 498044),
  ("Long Beach", "LB01", 467353),
  ("Colorado Springs", "COS01", 478221),
  ("Raleigh", "RAL01", 474069),
  ("Miami", "MIA01", 454279),
  ("Virginia Beach", "VB01", 449974),
  ("Omaha", "OMA01", 446970),
  ("Oakland", "OAK01", 425195),
  ("Minneapolis", "MIN01", 429606),
  ("Tulsa", "TUL01", 401190),
  ("Arlington", "ARL01", 398854);

-- Create some states.
INSERT INTO states (name, abbreviation, population) VALUES
  ('Alabama', 'AL', 5024279),
  ('Alaska', 'AK', 731545),
  ('Arizona', 'AZ', 7151502),
  ('Arkansas', 'AR', 3011524),
  ('California', 'CA', 39538223),
  ('Colorado', 'CO', 5773714),
  ('Connecticut', 'CT', 3608298),
  ('Delaware', 'DE', 989948),
  ('Florida', 'FL', 21538187),
  ('Georgia', 'GA', 10711908),
  ('Hawaii', 'HI', 1455271),
  ('Idaho', 'ID', 1839106),
  ('Illinois', 'IL', 12812508),
  ('Indiana', 'IN', 6794422),
  ('Iowa', 'IA', 3190369),
  ('Kansas', 'KS', 2937880),
  ('Kentucky', 'KY', 4505836),
  ('Louisiana', 'LA', 4657757),
  ('Maine', 'ME', 1362359),
  ('Maryland', 'MD', 6177224),
  ('Massachusetts', 'MA', 7029917),
  ('Michigan', 'MI', 10077331),
  ('Minnesota', 'MN', 5706494),
  ('Mississippi', 'MS', 2961279),
  ('Missouri', 'MO', 6154913),
  ('Montana', 'MT', 1084225),
  ('Nebraska', 'NE', 1952570),
  ('Nevada', 'NV', 3139658),
  ('New Hampshire', 'NH', 1377529),
  ('New Jersey', 'NJ', 9288994),
  ('New Mexico', 'NM', 2117522),
  ('New York', 'NY', 20201249),
  ('North Carolina', 'NC', 10439388),
  ('North Dakota', 'ND', 779094),
  ('Ohio', 'OH', 11799448),
  ('Oklahoma', 'OK', 3959353),
  ('Oregon', 'OR', 4301089),
  ('Pennsylvania', 'PA', 12820878),
  ('Rhode Island', 'RI', 1097379),
  ('South Carolina', 'SC', 5210095),
  ('South Dakota', 'SD', 903027),
  ('Tennessee', 'TN', 6897576),
  ('Texas', 'TX', 29472295),
  ('Utah', 'UT', 3282115),
  ('Vermont', 'VT', 623989),
  ('Virginia', 'VA', 8626207),
  ('Washington', 'WA', 7693612),
  ('West Virginia', 'WV', 1778070),
  ('Wisconsin', 'WI', 5893718),
  ('Wyoming', 'WY', 576851);

-- Create some countries.
INSERT INTO countries
  (name, country_code, population) VALUES
  ('United States', 'USA', 331002651),
  ('China', 'CHN', 1439323776),
  ('India', 'IND', 1380004385),
  ('Indonesia', 'IDN', 273523615),
  ('Pakistan', 'PAK', 220892340),
  ('Brazil', 'BRA', 212559417),
  ('Nigeria', 'NGA', 206139589),
  ('Bangladesh', 'BGD', 164689383),
  ('Russia', 'RUS', 145934462),
  ('Mexico', 'MEX', 128932753);

-- Create some political parties for affiliations.
INSERT INTO parties
  (name, description) VALUES
  ('Democratic Party', 'A political party advocating for social and economic equality.'),
  ('Republican Party', 'A political party advocating for conservative policies.'),
  ('Green Party', 'A political party advocating for environmentalism, social justice, and grassroots democracy.'),
  ('Libertarian Party', 'A political party advocating for minimal government intervention and maximum individual freedom.');

-- Create some congressional districts. Not exhaustive.
INSERT INTO districts
  (name, district_number, population) VALUES
  ('New York 12th Congressional District', 12, 740998),
  ('California 27th Congressional District', 27, 723050),
  ('Texas 10th Congressional District', 10, 801147),
  ('Florida 26th Congressional District', 26, 761549),
  ('Illinois 3rd Congressional District', 3, 711127),
  ('Pennsylvania 18th Congressional District', 18, 717364),
  ('Ohio 14th Congressional District', 14, 738004),
  ('Georgia 6th Congressional District', 6, 746675),
  ('North Carolina 9th Congressional District', 9, 777194),
  ('Michigan 13th Congressional District', 13, 747334);

-- Create some citizens and their accounts.
INSERT INTO citizens
  (name, ssn, dob, address, city_id, state_id, country_id, district_id, affiliation) VALUES
  ("John Doe", "123456789", "1985-03-15", "123 Main St", 1, 1, 1, 1, 1),
  ("Jane Smith", "987654321", "1990-09-20", "456 Elm St", 2, 2, 1, 2, 1),
  ("Alice Johnson", "456789123", "1978-11-10", "789 Oak St", 3, 3, 1, 3, 1),
  ("Bob Williams", "789123456", "1982-07-05", "101 Maple St", 1, 2, 1, 1, 1),
  ("Emily Brown", "321654987", "1995-04-25", "202 Pine St", 2, 3, 1, 2, 2),
  ("Michael Davis", "654789321", "1973-12-30", "303 Cedar St", 3, 1, 1, 3, 2),
  ("Sarah Miller", "147258369", "1988-10-15", "404 Oakwood St", 1, 3, 1, 1, 2),
  ("David Wilson", "852369741", "1992-01-12", "505 Elmwood St", 2, 1, 1, 2, 2),
  ("Laura Martinez", "369147258", "1980-06-08", "606 Birch St", 3, 2, 1, 3, NULL),
  ("Christopher Taylor", "258369147", "1976-09-03", "707 Maplewood St", 1, 1, 1, 1, NULL);
-- The citizen with ID 69 is a special citizen that represents deleted citizens.
INSERT INTO citizens (citizen_id, name, ssn, dob, address) VALUES (69, "NULL ENTITY", "000000000", "1970-01-01", "");
INSERT INTO citizen_accounts
  (citizen_id, email, password) VALUES
  (1, "johndoe@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (2, "janesmith@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (3, "alicejohnson@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (4, "bobwilliams@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (5, "emilybrown@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (6, "michaeldavis@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (7, "sarahmiller@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (8, "davidwilson@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (9, "lauramartinez@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (10, "christophertaylor@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi");

-- Create some candidates and their accounts.
INSERT INTO candidates
  (name, ssn, dob, address, city_id, state_id, country_id, affiliation) VALUES
  ("Joe Biden", "123123123", "1942-11-20", "1600 Pennsylvania Ave NW", 1, 11, 1, 1),
  ("Donald Trump", "321321321", "1946-06-14", "1600 Pennsylvania Ave NW", 1, 11, 1, 2),
  ("Jo Jorgensen", "010382838", "1957-05-01", "1234 Libertarian Ave", 2, 2, 1, 3),
  ("Howie Hawkins", "606060606", "1952-12-08", "567 Green St", 3, 3, 1, 4);
INSERT INTO candidate_accounts
  (candidate_id, email, password) VALUES
  (1, "joebiden@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (2, "donaldtrump@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (3, "jojorgensen@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (4, "howiehawkins@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi");

-- Create some election candidates, their accounts and roles.
INSERT INTO election_admins (name, ssn, dob, address, city_id, state_id, country_id) VALUES
  ("Doe John", "871263999", "1985-03-15", "321 Main St", 1, 1, 1),
  ("Smith Jane", "827382917", "1990-09-20", "654 Elm St", 2, 2, 1),
  ("Johnson Alice", "374827384", "1978-11-10", "987 Oak St", 3, 3, 1);
INSERT INTO election_admin_accounts
  (admin_id, email, password) VALUES
  (1, "doejohn@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (2, "smithjane@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi"),
  (3, "johnsonalice@example.com", "$2a$10$d5Fq9SGfSud5KsM9RAVCQeYxrQSNNzi.7amuE9SpuKpKRg5bcVRpi");
INSERT INTO roles
  (name, description) VALUES
  ("admin", "Administrator role with full access"),
  ("delete_votes", "Remove votes from an election"),
  ("mark_suspicious", "Mark a vote as suspicious"),
  ("create_election", "Create an election");
INSERT INTO election_admin_roles
  (election_admin_id, role_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (3, 4);

-- Create some sample election log events.
INSERT INTO election_audit_log (name, payload, election_admin_id) VALUES
  ("election_created", '{"election_id": 1}', 3),
  ("vote_deleted",  '{"election_type": "electoral", "candidate_id": 1, "voter_id": 2, "election_id": 1}', 2),
  ("election_ended",  '{"election_id": 1}', 1);

-- Create some popular elections and seed one with some votes.
INSERT INTO popular_elections
  (name, description, year, voting_deadline, required_margin) VALUES
  ("2020 Presidential Election", "2020 Election for the President of the United States", DATE("2020-01-01"), TIMESTAMP("2020-11-03 23:59:59"), 0.50),
  ("2020 Senate Election", "2020 Election for the United States Senate", DATE("2020-01-01"), TIMESTAMP("2020-11-03 23:59:59"), 0.50),
  ("2020 House of Representatives Election", "2020 Election for the United States House of Representatives", DATE("2020-01-01"), TIMESTAMP("2020-11-03 23:59:59"), 0.50);
INSERT INTO popular_election_candidates
  (candidate_id, election_id) VALUES
  (1, 1),
  (2, 1),
  (3, 1);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, 1);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, 2);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, 3);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, 4);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, 5);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (2, 1, 6);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (2, 1, 7);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (2, 1, 8);
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (2, 1, 9); 
INSERT INTO popular_election_votes (candidate_id, election_id, voter_id, status) VALUES (2, 1, 10, "SUSPICIOUS");

-- Create some electoral elections and seed one with some votes.
INSERT INTO electoral_elections
  (name, description, year, voting_deadline, required_votes_for_victory) VALUES
  ('2020 Presidential Election', '2020 Election for the President of the United States', DATE('2020-01-01'), TIMESTAMP('2020-11-03 23:59:59'), 270),
  ('2016 Presidential Election', '2020 Election for the President of the United States', DATE('2016-01-01'), TIMESTAMP('2020-11-08 23:59:59'), 270),
  ('2012 Presidential Election', '2020 Election for the President of the United States', DATE('2012-01-01'), TIMESTAMP('2020-11-06 23:59:59'), 270);
INSERT INTO electoral_election_candidates
  (candidate_id, election_id) VALUES
  (1, 1),
  (2, 1),
  (3, 1);
INSERT INTO electoral_election_votes
  (candidate_id, election_id, voter_id) VALUES
  (1, 1, 1) ,
  (2, 2, 2),
  (3, 3, 3);
INSERT INTO electoral_election_votes
  (candidate_id, election_id, voter_id, status) VALUES
  (4, 1, 1, "SUSPICIOUS");

-- Create some referendums and seed one with some votes.
INSERT INTO referendums (name, description, year, voting_deadline) VALUES
  ("Referendum on Education Funding", "Vote on increasing funding for public education", DATE("2020-01-01"), TIMESTAMP("2024-11-03 23:59:59")),
  ("Referendum on Healthcare Reform", "Vote on proposed healthcare reform policies", DATE("2020-01-01"), TIMESTAMP("2024-11-03 23:59:59")),
  ("Referendum on Environmental Protection", "Vote on measures to protect the environment", DATE("2020-01-01"), TIMESTAMP("2024-11-03 23:59:59"));
INSERT INTO referendum_option_categories (name, description) VALUES
  ("Affirmative", "An affirmation"),
  ("Rejective", "A rejection"),
  ("No Action", "No action to be taken");
INSERT INTO referendum_options
  (referendum_id, name, description, category) VALUES
  (1, "Increase Funding", "Option to increase funding for education", 1),
  (1, "Don't Increase Funding", "Option to not increase funding for education", 2),
  (1, "Decrease Increase Funding", "Option to not increase funding for education", 3);
INSERT INTO referendum_votes
  (option_id, referendum_id, voter_id) VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 1, 3);
INSERT INTO referendum_votes
  (option_id, referendum_id, voter_id, status) VALUES
  (3, 1, 4, "SUSPICIOUS");

-- Create some initiatives and seed one with some votes.
INSERT INTO initiative_categories (name, description) VALUES
  ("Education", "Initiatives related to education policies"),
  ("Healthcare", "Initiatives related to healthcare reforms"),
  ("Environment", "Initiatives related to environmental protection");
INSERT INTO initiatives (name, description, voting_deadline, required_votes, category) VALUES
  ("Education Reform Act", "Proposal for comprehensive education reforms", TIMESTAMP("2020-11-03 23:59:59"), 5, 1),
  ("Healthcare Access Initiative", "Plan to improve access to healthcare for all citizens", TIMESTAMP("2020-11-03 23:59:59"), 5, 2),
  ("Green Energy Initiative", "Promotion of renewable energy adoption", TIMESTAMP("2020-11-03 23:59:59"), 5, 3);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 1);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 2);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 3);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 4);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 5);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 6);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 7);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 8);
INSERT INTO initiative_votes (initiative_id, voter_id) VALUES (1, 9);
INSERT INTO initiative_votes (initiative_id, voter_id, status) VALUES (1, 10, "SUSPICIOUS");

SET @DISABLE_TRIGGERS = NULL;

-- Delete data so this script can be ran again for testing.
-- This block also sets the autoincrement back to 1 for
-- consistent IDs when seeding.
-- DELETE FROM cities;
-- ALTER TABLE cities AUTO_INCREMENT = 1;
-- DELETE FROM states;
-- ALTER TABLE states AUTO_INCREMENT = 1;
-- DELETE FROM countries;
-- ALTER TABLE countries AUTO_INCREMENT = 1;
-- DELETE FROM parties;
-- ALTER TABLE parties AUTO_INCREMENT = 1;
-- DELETE FROM districts;
-- ALTER TABLE districts AUTO_INCREMENT = 1;
-- DELETE FROM citizens;
-- ALTER TABLE citizens AUTO_INCREMENT = 1;
-- DELETE FROM candidates;
-- ALTER TABLE candidates AUTO_INCREMENT = 1;
-- DELETE FROM election_admins;
-- ALTER TABLE election_admins AUTO_INCREMENT = 1;
-- DELETE FROM roles;
-- ALTER TABLE roles AUTO_INCREMENT = 1;
-- DELETE FROM popular_elections;
-- ALTER TABLE popular_elections AUTO_INCREMENT = 1;
-- DELETE FROM electoral_elections;
-- ALTER TABLE electoral_elections AUTO_INCREMENT = 1;
-- DELETE FROM referendums;
-- ALTER TABLE referendums AUTO_INCREMENT = 1;
-- DELETE FROM referendum_option_categories;
-- ALTER TABLE referendum_option_categories AUTO_INCREMENT = 1;
-- DELETE FROM initiatives;
-- ALTER TABLE initiatives AUTO_INCREMENT = 1;
-- DELETE FROM initiative_categories;
-- ALTER TABLE initiative_categories AUTO_INCREMENT = 1;
