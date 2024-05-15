USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS CitizenCandidateVotes;
CREATE PROCEDURE CitizenCandidateVotes(IN cid INT)
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
END
$$

DELIMITER ;

CALL CitizenCandidateVotes(1);
