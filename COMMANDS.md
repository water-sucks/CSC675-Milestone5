---
title: "CSC-675: Voting System Database Requirements"
author: Varun Narravula
---

# Commands

-   Testing Triggers That Require Manual Inserts

    -   11

-   [-] `/election-result` :: find results of an election
    -   [x] Popular (1)
    -   [ ] Electoral (2)
    -   [ ] Referendum (3)
    -   [x] Initiative (4)
    -   `election_type` :: `popular` | `electoral` | `referendum` | `initiative`
    -   `election_id` :: `number`
-   [x] `/remove-suspicious-votes` :: remove all suspicious votes at once (5, 6)
-   [x] `/citizen-votes` :: find all votes that citizen has cast (7)
-   [x] `/patriots` :: list all citizens with more than 3 votes (8)
-   [x] `/remove-citizen` :: remove votes for citizen (9)
    -   `citizen_id` :: `number`
-   [ ] `/affiliation-map` :: find states' affiliations for a popular election (10)
    -   `election_id` :: `number`
-   [x] `/list-elections` :: find available elections (12)
-   [x] `/voter-turnout` :: find voter turnout for an election (13)
    -   [x] Popular
    -   [x] Electoral
    -   [x] Referendum
    -   [x] Initiative
    -   `election_type` :: `popular` | `electoral` | `referendum` | `initiative`
    -   `election_id` :: `number`
-   [x] `/candidate-history` :: Find how many times each candidate has participated in elections (14)
-   [x] `/party-popularities` :: Show popularity of political parties (15)
