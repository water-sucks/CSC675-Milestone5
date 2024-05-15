USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS PartyPopularities;
CREATE PROCEDURE PartyPopularities()
BEGIN
  SELECT 
    COUNT(*) AS affiliation_count, 
    COALESCE((SELECT name FROM parties WHERE party_id = affiliation), "Independent") AS party_name
  FROM citizens
  GROUP BY affiliation;
END
$$

DELIMITER ;

CALL PartyPopularities;
