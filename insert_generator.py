for i in range(1, 6):
    print(
        f"INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (1, 1, {i});"
    )
for i in range(6, 11):
    print(
        f"INSERT INTO popular_election_votes (candidate_id, election_id, voter_id) VALUES (2, 1, {i});"
    )
