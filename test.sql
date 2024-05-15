USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS FindElections;
CREATE PROCEDURE FindElections()
BEGIN
  SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, "Popular" AS election_type FROM popular_elections
  UNION ALL
  SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Electoral' AS election_type FROM electoral_elections
  UNION ALL
  SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Referendum' AS election_type FROM referendums
  UNION ALL
  SELECT name, description, voting_deadline, CURRENT_TIMESTAMP < voting_deadline AS can_still_vote, 'Initiative' AS election_type FROM initiatives
  ORDER BY voting_deadline ASC;
END
$$

DELIMITER ;

CALL FindElections;
