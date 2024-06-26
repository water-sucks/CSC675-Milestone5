---
title: "CSC-675: Voting System Database Requirements"
author: Varun Narravula
---

# Requirements

1. Implement a command that easily will find the current winner of a popular
   election at a given time, using the required margin of victory. If the
   required margin of victory is not satisfied by any one candidate, then no one
   has won the election.
2. Implement a command that easily will find the current winner of an electoral
   election at a given time, using the required number of electoral votes. Each
   electoral vote is counted by finding the winner in a district and counting
   that as a single electoral vote. If the required number of electoral votes is
   not satisfied by any one candidate, then no one has won the election.
3. Implement a command that easily will find the most voted-for option of a
   referendum at a given time.
4. Implement a command that easily will find if an initiative has been passed
   (aka if the initiative has enough yes votes to pass the threshold).
5. Any action taken by an election administrator on the election votes tables
   will be recorded in the election audit log.
6. Votes marked as suspicious for all election types can be removed at any time,
   and will not count towards victory for prior commands.
7. Find all votes from a citizen for popular and electoral elections, sorted by
   time of vote.
8. Show a list of "patriot" citizens that have voted more than 3 times.
9. If a voter is deleted, then all votes for that user will be unlinked to them,
   but will still remain in the DB for archival purposes.
10.   Implement a command that lists states and their affiliation leanings for a
      particular popular election.
11.   Reject (fail) the insertion of votes after an election deadline.
12.   Implement a command that list all elections that are possible to vote in.
13.   Find the percentage of voter turnout for an election.
14.   Find the number of times every candidate has participated in an election.
15.   Find the number of citizens affiliated with each political party.
