USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS InitiativePassed;
CREATE PROCEDURE InitiativePassed(IN eid INT)
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
END
$$

DELIMITER ;

CALL InitiativePassed(1);
