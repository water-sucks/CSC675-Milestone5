package main

type Patriot struct {
	ID            int
	Name          string
	NumberOfVotes int
}

type PopularElectionWinner struct {
	Name          string
	NumberOfVotes int
	Margin        int
}

type InitiativePassedResult struct {
	Name                  string
	Passed                bool
	RequiredNumberOfVotes int
	NumberOfVotes         int
}

type PartyPopularityResult struct {
	Name             string
	AffiliationCount int
}

type CandidateHistoryResult struct {
	ID                int
	Name              string
	NumberOfElections int
}
