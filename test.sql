USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS Patriots;
CREATE PROCEDURE Patriots()
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
END
$$

DELIMITER ;

CALL Patriots;
