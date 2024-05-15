-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VotingSystemsDB
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `VotingSystemsDB`;
CREATE DATABASE IF NOT EXISTS `VotingSystemsDB`;
USE `VotingSystemsDB`;
-- -----------------------------------------------------
-- Table `cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cities` ;

CREATE TABLE IF NOT EXISTS `cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `city_code` VARCHAR(10) NOT NULL,
  `population` INT NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `states` ;

CREATE TABLE IF NOT EXISTS `states` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `abbreviation` VARCHAR(2) NOT NULL,
  `population` INT NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `countries` ;

CREATE TABLE IF NOT EXISTS `countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `country_code` VARCHAR(5) NOT NULL,
  `population` INT NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `districts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `districts` ;

CREATE TABLE IF NOT EXISTS `districts` (
  `district_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `district_number` INT NOT NULL,
  `population` INT NOT NULL,
  PRIMARY KEY (`district_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `parties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `parties` ;

CREATE TABLE IF NOT EXISTS `parties` (
  `party_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`party_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citizens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `citizens` ;

CREATE TABLE IF NOT EXISTS `citizens` (
  `citizen_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `ssn` VARCHAR(9) NOT NULL,
  `dob` DATE NOT NULL,
  `address` VARCHAR(200) NULL,
  `city_id` INT NULL,
  `state_id` INT NULL,
  `country_id` INT NULL,
  `district_id` INT NULL,
  `affiliation` INT NULL,
  PRIMARY KEY (`citizen_id`),
  INDEX `fk_citizen_city_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_citizen_state1_idx` (`state_id` ASC) VISIBLE,
  INDEX `fk_citizen_country1_idx` (`country_id` ASC) VISIBLE,
  INDEX `fk_citizen_district1_idx` (`district_id` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  INDEX `fk_citizens_parties1_idx` (`affiliation` ASC) VISIBLE,
  CONSTRAINT `fk_citizen_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`city_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `states` (`state_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`country_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_district1`
    FOREIGN KEY (`district_id`)
    REFERENCES `districts` (`district_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizens_parties1`
    FOREIGN KEY (`affiliation`)
    REFERENCES `parties` (`party_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `election_admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `election_admins` ;

CREATE TABLE IF NOT EXISTS `election_admins` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `ssn` VARCHAR(9) NOT NULL,
  `dob` DATE NOT NULL,
  `address` VARCHAR(200) NULL,
  `city_id` INT NULL,
  `state_id` INT NULL,
  `country_id` INT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `fk_citizen_city_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_citizen_state1_idx` (`state_id` ASC) VISIBLE,
  INDEX `fk_citizen_country1_idx` (`country_id` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  CONSTRAINT `fk_citizen_city0`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`city_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_state10`
    FOREIGN KEY (`state_id`)
    REFERENCES `states` (`state_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_country10`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`country_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `candidates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `candidates` ;

CREATE TABLE IF NOT EXISTS `candidates` (
  `candidate_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `ssn` VARCHAR(9) NOT NULL,
  `dob` DATE NOT NULL,
  `address` VARCHAR(200) NULL,
  `city_id` INT NULL,
  `state_id` INT NULL,
  `country_id` INT NULL,
  `affiliation` INT NULL,
  PRIMARY KEY (`candidate_id`),
  INDEX `fk_citizen_city_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_citizen_state1_idx` (`state_id` ASC) VISIBLE,
  INDEX `fk_citizen_country1_idx` (`country_id` ASC) VISIBLE,
  INDEX `fk_citizen_party1_idx` (`affiliation` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  CONSTRAINT `fk_citizen_city00`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`city_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_state100`
    FOREIGN KEY (`state_id`)
    REFERENCES `states` (`state_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_country100`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`country_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_citizen_party100`
    FOREIGN KEY (`affiliation`)
    REFERENCES `parties` (`party_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citizen_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `citizen_accounts` ;

CREATE TABLE IF NOT EXISTS `citizen_accounts` (
  `citizen_id` INT NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password_expiry` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_citizen_accounts_citizens1_idx` (`citizen_id` ASC) VISIBLE,
  CONSTRAINT `fk_citizen_accounts_citizens1`
    FOREIGN KEY (`citizen_id`)
    REFERENCES `citizens` (`citizen_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `candidate_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `candidate_accounts` ;

CREATE TABLE IF NOT EXISTS `candidate_accounts` (
  `candidate_id` INT NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password_expiry` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_candidate_accounts_candidates1_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidate_accounts_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidates` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election_admin_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `election_admin_accounts` ;

CREATE TABLE IF NOT EXISTS `election_admin_accounts` (
  `admin_id` INT NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password_expiry` DATETIME NOT NULL,
  INDEX `fk_election_admin_accounts_election_admins1_idx` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_election_admin_accounts_election_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `election_admins` (`admin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roles` ;

CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election_admin_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `election_admin_roles` ;

CREATE TABLE IF NOT EXISTS `election_admin_roles` (
  `assigned_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` VARCHAR(200) NULL,
  `election_admin_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  INDEX `fk_election_admin_roles_election_admins1_idx` (`election_admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_election_admin_roles_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_election_admin_roles_election_admins1`
    FOREIGN KEY (`election_admin_id`)
    REFERENCES `election_admins` (`admin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election_audit_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `election_audit_log` ;

CREATE TABLE IF NOT EXISTS `election_audit_log` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `payload` VARCHAR(1000) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `election_admin_id` INT NULL,
  PRIMARY KEY (`event_id`),
  INDEX `fk_election_audit_log_election_admins1_idx` (`election_admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_election_audit_log_election_admins1`
    FOREIGN KEY (`election_admin_id`)
    REFERENCES `election_admins` (`admin_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popular_elections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `popular_elections` ;

CREATE TABLE IF NOT EXISTS `popular_elections` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` DATE NOT NULL,
  `voting_deadline` DATETIME NOT NULL,
  `required_margin` DECIMAL NOT NULL,
  PRIMARY KEY (`election_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `electoral_elections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `electoral_elections` ;

CREATE TABLE IF NOT EXISTS `electoral_elections` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` DATE NOT NULL,
  `voting_deadline` DATETIME NOT NULL,
  `required_votes_for_victory` INT NOT NULL,
  PRIMARY KEY (`election_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `referendums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `referendums` ;

CREATE TABLE IF NOT EXISTS `referendums` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `year` DATE NOT NULL,
  `voting_deadline` DATETIME NOT NULL,
  PRIMARY KEY (`election_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popular_election_candidates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `popular_election_candidates` ;

CREATE TABLE IF NOT EXISTS `popular_election_candidates` (
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(45) NOT NULL DEFAULT 'RUNNING',
  `notes` VARCHAR(200) NULL,
  `candidate_id` INT NOT NULL,
  `election_id` INT NOT NULL,
  PRIMARY KEY (`candidate_id`, `election_id`),
  INDEX `fk_popular_election_candidates_popular_elections1_idx` (`election_id` ASC) VISIBLE,
  CONSTRAINT `fk_popular_election_candidates_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidates` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_popular_election_candidates_popular_elections1`
    FOREIGN KEY (`election_id`)
    REFERENCES `popular_elections` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `electoral_election_candidates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `electoral_election_candidates` ;

CREATE TABLE IF NOT EXISTS `electoral_election_candidates` (
  `created_at` VARCHAR(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `status` VARCHAR(45) NOT NULL DEFAULT 'RUNNING',
  `notes` VARCHAR(45) NULL,
  `candidate_id` INT NOT NULL,
  `election_id` INT NOT NULL,
  PRIMARY KEY (`candidate_id`, `election_id`),
  INDEX `fk_popular_election_candidates_copy1_electoral_elections1_idx` (`election_id` ASC) VISIBLE,
  CONSTRAINT `fk_popular_election_candidates_candidates10`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidates` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_popular_election_candidates_copy1_electoral_elections1`
    FOREIGN KEY (`election_id`)
    REFERENCES `electoral_elections` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popular_election_votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `popular_election_votes` ;

CREATE TABLE IF NOT EXISTS `popular_election_votes` (
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(20) NOT NULL DEFAULT 'CAST',
  `notes` VARCHAR(200) NULL,
  `candidate_id` INT NOT NULL,
  `election_id` INT NOT NULL,
  `voter_id` INT NULL,
  INDEX `fk_popular_election_votes_citizens1_idx` (`voter_id` ASC) VISIBLE,
  CONSTRAINT `fk_popular_election_votes_citizens1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `citizens` (`citizen_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_popular_election_votes_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidates` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_popular_election_votes_popular_elections1`
    FOREIGN KEY (`election_id`)
    REFERENCES `popular_elections` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `electoral_election_votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `electoral_election_votes` ;

CREATE TABLE IF NOT EXISTS `electoral_election_votes` (
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(20) NOT NULL DEFAULT 'CAST',
  `notes` VARCHAR(200) NULL,
  `candidate_id` INT NOT NULL,
  `election_id` INT NOT NULL,
  `voter_id` INT NULL,
  CONSTRAINT `fk_electoral_election_votes_citizens1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `citizens` (`citizen_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_electoral_election_votes_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `candidates` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_electoral_election_votes_electoral_elections1`
    FOREIGN KEY (`election_id`)
    REFERENCES `electoral_elections` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `referendum_option_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `referendum_option_categories` ;

CREATE TABLE IF NOT EXISTS `referendum_option_categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `notes` VARCHAR(200) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `referendum_options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `referendum_options` ;

CREATE TABLE IF NOT EXISTS `referendum_options` (
  `option_id` INT NOT NULL AUTO_INCREMENT,
  `referendum_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `notes` VARCHAR(45) NULL,
  `category` INT NULL,
  PRIMARY KEY (`option_id`, `referendum_id`),
  INDEX `fk_referendum_options_referendum_option_category1_idx` (`category` ASC) VISIBLE,
  INDEX `fk_referendum_options_referendums1_idx` (`referendum_id` ASC) VISIBLE,
  CONSTRAINT `fk_referendum_options_referendum_option_category1`
    FOREIGN KEY (`category`)
    REFERENCES `referendum_option_categories` (`category_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_referendum_options_referendums1`
    FOREIGN KEY (`referendum_id`)
    REFERENCES `referendums` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `referendum_votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `referendum_votes` ;

CREATE TABLE IF NOT EXISTS `referendum_votes` (
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(200) NOT NULL DEFAULT 'CAST',
  `notes` VARCHAR(45) NULL,
  `option_id` INT NOT NULL,
  `referendum_id` INT NOT NULL,
  `voter_id` INT NULL,
  PRIMARY KEY (`option_id`, `referendum_id`),
  INDEX `fk_referendum_votes_referendums1_idx` (`referendum_id` ASC) VISIBLE,
  CONSTRAINT `fk_referendum_votes_citizens1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `citizens` (`citizen_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_referendum_votes_referendum_options1`
    FOREIGN KEY (`option_id`)
    REFERENCES `referendum_options` (`option_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_referendum_votes_referendums1`
    FOREIGN KEY (`referendum_id`)
    REFERENCES `referendums` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `initiative_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `initiative_categories` ;

CREATE TABLE IF NOT EXISTS `initiative_categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `notes` VARCHAR(200) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `initiatives`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `initiatives` ;

CREATE TABLE IF NOT EXISTS `initiatives` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `voting_deadline` DATETIME NOT NULL,
  `required_votes` INT NOT NULL,
  `category` INT NULL,
  PRIMARY KEY (`election_id`),
  INDEX `fk_initiatives_initiative_categories1_idx` (`category` ASC) VISIBLE,
  CONSTRAINT `fk_initiatives_initiative_categories1`
    FOREIGN KEY (`category`)
    REFERENCES `initiative_categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `initiative_votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `initiative_votes` ;

CREATE TABLE IF NOT EXISTS `initiative_votes` (
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(20) NOT NULL DEFAULT 'CAST',
  `notes` VARCHAR(200) NULL,
  `initiative_id` INT NOT NULL,
  `voter_id` INT NULL,
  INDEX `fk_initiative_votes_citizens1_idx` (`voter_id` ASC) VISIBLE,
  CONSTRAINT `fk_initiative_votes_initiatives1`
    FOREIGN KEY (`initiative_id`)
    REFERENCES `initiatives` (`election_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_initiative_votes_citizens1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `citizens` (`citizen_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `view1` (`id` INT);

-- -----------------------------------------------------
-- procedure Patriots
-- -----------------------------------------------------
DROP procedure IF EXISTS `Patriots`;

DELIMITER $$
CREATE PROCEDURE `Patriots` ()
BEGIN
	SELECT 
    citizen_id AS id,
    (SELECT name FROM citizens WHERE citizen_id = id) AS name,
    SUM(vote_count)
  AS vote_count FROM (
    SELECT voter_id AS citizen_id, COUNT(*) AS vote_count FROM popular_election_votes GROUP BY citizen_id
    UNION ALL
    SELECT voter_id AS citizen_id, COUNT(*) AS vote_count FROM electoral_election_votes GROUP BY citizen_id
    UNION ALL
    SELECT voter_id AS citizen_id, COUNT(*) AS vote_count FROM referendum_votes GROUP BY citizen_id
    UNION ALL
    SELECT voter_id AS citizen_id, COUNT(*) AS vote_count FROM initiative_votes GROUP BY citizen_id
  ) votes GROUP BY id HAVING vote_count > 3;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PopularElectionWinner
-- -----------------------------------------------------
DROP procedure IF EXISTS `PopularElectionWinner`;

DELIMITER $$
CREATE PROCEDURE `PopularElectionWinner` (IN eid INT)
BEGIN
  DECLARE required_margin_of_victory INT DEFAULT 0;
  DECLARE total_vote_count INT DEFAULT 1;
  DECLARE first_place_vote_count INT DEFAULT 0;
  DECLARE second_place_vote_count INT DEFAULT 0;
  DECLARE margin_of_victory INT DEFAULT 0;
  DECLARE winner_id INT DEFAULT NULL;

  SELECT required_margin INTO required_margin_of_victory FROM popular_elections WHERE election_id = eid;
  SELECT IF(COUNT(*) <> 0, COUNT(*), 1) INTO total_vote_count FROM popular_election_votes WHERE election_id = eid;

  DROP TABLE IF EXISTS vote_counts;
  CREATE TEMPORARY TABLE vote_counts (candidate_id INT, votes INT);
  INSERT INTO vote_counts SELECT
    candidate_id,
    votes
  FROM
    (
      SELECT
        candidate_id,
        COUNT(*) AS votes
      FROM
        popular_election_votes
      WHERE
        election_id = eid
      GROUP BY
        candidate_id
    ) vote_counts
  ORDER BY
    votes DESC;


  SELECT IFNULL(votes, 0) INTO first_place_vote_count FROM vote_counts LIMIT 0,1;
  SELECT IFNULL(votes, 0) INTO second_place_vote_count FROM vote_counts LIMIT 1,1;

  SELECT candidate_id INTO winner_id FROM vote_counts WHERE votes = first_place_vote_count LIMIT 1;

  SELECT (first_place_vote_count - second_place_vote_count) / total_vote_count * 100 INTO margin_of_victory;
  SELECT IF(margin_of_victory >= required_margin_of_victory, winner_id, NULL) INTO winner_id;

  SELECT name, first_place_vote_count, margin_of_victory FROM candidates WHERE candidate_id = winner_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InitiativePassed
-- -----------------------------------------------------
DROP procedure IF EXISTS `InitiativePassed`;

DELIMITER $$
CREATE PROCEDURE `InitiativePassed` (IN eid INT)
BEGIN
  DECLARE required INT DEFAULT 0;

  SELECT required_votes INTO required FROM initiatives WHERE election_id = eid LIMIT 1;

  SELECT
    (SELECT name FROM initiatives WHERE election_id = eid LIMIT 1) AS name,
    IF (COUNT(*) >= required AND COUNT(*) <> 0, TRUE, FALSE) AS passed,
    required,
    COUNT(*) AS vote_count
  FROM initiative_votes
  WHERE initiative_id = eid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PartyPopularity
-- -----------------------------------------------------
DROP procedure IF EXISTS `PartyPopularity`;

DELIMITER $$
CREATE PROCEDURE `PartyPopularity` ()
BEGIN
	SELECT 
		COUNT(*) AS affiliation_count, 
		COALESCE((SELECT name FROM parties WHERE party_id = affiliation), "Independent") AS party_name
	FROM citizens
	GROUP BY affiliation;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CandidateHistory
-- -----------------------------------------------------
DROP procedure IF EXISTS `CandidateHistory`;

DELIMITER $$
CREATE PROCEDURE `CandidateHistory` ()
BEGIN
	SELECT
		candidate_id AS id,
		(SELECT name FROM candidates WHERE candidate_id = id) AS name,
		SUM(election_count) AS election_count
	FROM (
		SELECT candidate_id, COUNT(*) AS election_count FROM popular_election_candidates GROUP BY candidate_id
		UNION ALL
		SELECT candidate_id, COUNT(*) AS election_count FROM electoral_election_candidates GROUP BY candidate_id
	) candidate_counts
	GROUP BY candidate_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FindElections
-- -----------------------------------------------------
DROP procedure IF EXISTS `FindElections`;

DELIMITER $$
CREATE PROCEDURE `FindElections` ()
BEGIN
	SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, "Popular" AS election_type FROM popular_elections
	UNION ALL
	SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Electoral' AS election_type FROM electoral_elections
	UNION ALL
	SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Referendum' AS election_type FROM referendums
	UNION ALL
	SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Initiative' AS election_type FROM initiatives
	ORDER BY voting_deadline ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PopularElectionTurnout
-- -----------------------------------------------------
DROP procedure IF EXISTS `PopularElectionTurnout`;

DELIMITER $$
CREATE PROCEDURE `PopularElectionTurnout` (IN eid INT)
BEGIN
	SELECT name, (
		(SELECT COUNT(*) FROM popular_election_votes WHERE election_id = eid) /
		(SELECT COUNT(*) FROM citizens)
	) * 100 AS voter_turnout FROM popular_elections WHERE election_id = eid LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ElectoralElectionTurnout
-- -----------------------------------------------------
DROP procedure IF EXISTS `ElectoralElectionTurnout`;

DELIMITER $$
CREATE PROCEDURE `ElectoralElectionTurnout` (IN eid INT)
BEGIN
	SELECT name, (
		(SELECT COUNT(*) FROM electoral_election_votes WHERE election_id = eid) /
		(SELECT COUNT(*) FROM citizens)
	) * 100 AS voter_turnout FROM electoral_elections WHERE election_id = eid LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ReferendumTurnout
-- -----------------------------------------------------
DROP procedure IF EXISTS `ReferendumTurnout`;

DELIMITER $$
CREATE PROCEDURE `ReferendumTurnout` (IN eid INT)
BEGIN
	SELECT name, (
		(SELECT COUNT(*) FROM referendum_votes WHERE election_id = eid) /
		(SELECT COUNT(*) FROM citizens)
	) * 100 AS voter_turnout FROM referendums WHERE election_id = eid LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InitiativeTurnout
-- -----------------------------------------------------
DROP procedure IF EXISTS `InitiativeTurnout`;

DELIMITER $$
CREATE PROCEDURE `InitiativeTurnout` (IN eid INT)
BEGIN
	SELECT name, (
		(SELECT COUNT(*) FROM initiative_votes WHERE election_id = eid) /
		(SELECT COUNT(*) FROM citizens)
	) * 100 AS voter_turnout FROM initiatives WHERE election_id = eid LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CitizenCandidateVotes
-- -----------------------------------------------------
DROP procedure IF EXISTS `CitizenCandidateVotes`;

DELIMITER $$
CREATE PROCEDURE `CitizenCandidateVotes` ()
BEGIN
	SELECT election_name, candidate_name, created_at FROM (
		SELECT
			voter_id,
			(SELECT name FROM popular_elections WHERE election_id = election_id LIMIT 1) AS election_name,
			(SELECT name FROM candidates WHERE candidate_id = candidate_id LIMIT 1) AS candidate_name,
			created_at
		FROM popular_election_votes
		UNION ALL
		SELECT
			voter_id,
			(SELECT name FROM electoral_elections WHERE election_id = election_id LIMIT 1) AS election_name,
			(SELECT name FROM candidates WHERE candidate_id = candidate_id LIMIT 1) AS candidate_name,
			created_at AS cast_at
		FROM electoral_election_votes
	) votes
	WHERE voter_id = cid
	ORDER BY created_at;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `view1`;
DROP VIEW IF EXISTS `view1` ;

DELIMITER $$

DROP TRIGGER IF EXISTS `citizen_accounts_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`citizen_accounts_BEFORE_INSERT` BEFORE INSERT ON `citizen_accounts` FOR EACH ROW
BEGIN
	SET NEW.password_expiry = TIMESTAMPADD(DAY, 180, NEW.created_at);
END$$


DROP TRIGGER IF EXISTS `candidate_accounts_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`candidate_accounts_BEFORE_INSERT` BEFORE INSERT ON `candidate_accounts` FOR EACH ROW
BEGIN
	SET NEW.password_expiry = TIMESTAMPADD(DAY, 180, NEW.created_at);
END$$


DROP TRIGGER IF EXISTS `election_admin_accounts_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`election_admin_accounts_BEFORE_INSERT` BEFORE INSERT ON `election_admin_accounts` FOR EACH ROW
BEGIN
	SET NEW.password_expiry = TIMESTAMPADD(DAY, 180, NEW.created_at);
END$$


DROP TRIGGER IF EXISTS `election_admin_roles_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`election_admin_roles_BEFORE_INSERT` BEFORE INSERT ON `election_admin_roles` FOR EACH ROW
BEGIN
	SET NEW.expiration_date = TIMESTAMPADD(DAY, 180, NEW.assigned_at);
END$$


DROP TRIGGER IF EXISTS `popular_election_votes_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`popular_election_votes_BEFORE_INSERT` BEFORE INSERT ON `popular_election_votes` FOR EACH ROW
BEGIN
	IF (@DISABLE_TRIGGERS IS NULL) THEN
		IF CURRENT_TIMESTAMP > (SELECT voting_deadline FROM popular_elections WHERE election_id = NEW.election_id LIMIT 1) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'voting deadline has passed';
		END IF;
	END IF;
END$$


DROP TRIGGER IF EXISTS `electoral_election_votes_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`electoral_election_votes_BEFORE_INSERT` BEFORE INSERT ON `electoral_election_votes` FOR EACH ROW
BEGIN
	IF (@DISABLE_TRIGGERS IS NULL) THEN
		IF CURRENT_TIMESTAMP > (SELECT voting_deadline FROM electoral_elections WHERE election_id = NEW.election_id LIMIT 1) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'voting deadline has passed';
		END IF;
    END IF;
END$$


DROP TRIGGER IF EXISTS `referendum_votes_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`referendum_votes_BEFORE_INSERT` BEFORE INSERT ON `referendum_votes` FOR EACH ROW
BEGIN
	IF (@DISABLE_TRIGGERS IS NULL) THEN
		IF CURRENT_TIMESTAMP > (SELECT voting_deadline FROM referendums WHERE election_id = NEW.referendum_id LIMIT 1) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'voting deadline has passed';
		END IF;
    END IF;
END$$


DROP TRIGGER IF EXISTS `initiative_votes_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `VotingSystemsDB`.`initiative_votes_BEFORE_INSERT` BEFORE INSERT ON `initiative_votes` FOR EACH ROW
BEGIN
	IF (@DISABLE_TRIGGERS IS NULL) THEN
		IF CURRENT_TIMESTAMP > (SELECT voting_deadline FROM initiatives WHERE election_id = NEW.initiative_id LIMIT 1) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'voting deadline has passed';
		END IF;
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

