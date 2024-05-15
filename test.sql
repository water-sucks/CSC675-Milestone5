USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS VoterTurnout;
CREATE PROCEDURE VoterTurnout(IN eid INT)
BEGIN
  SELECT name, (
    (SELECT COUNT(*) FROM initiative_votes WHERE election_id = eid) /
    (SELECT COUNT(*) FROM citizens)
  ) * 100 AS voter_turnout FROM initiatives WHERE election_id = eid LIMIT 1;
END
$$

DELIMITER ;

CALL VoterTurnout(10);
