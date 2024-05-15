-- Implement a command that easily will find the current winner of a popular
-- election at a given time, using the required margin of victory. If the
-- required margin of victory is not satisfied by any one candidate, then no one
-- has won the election.
USE VotingSystemsDB;

DELIMITER $$

DROP PROCEDURE IF EXISTS PopularElectionWinner;
CREATE PROCEDURE PopularElectionWinner(IN eid INT)
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
END
$$

DELIMITER ;

CALL PopularElectionWinner(5);
