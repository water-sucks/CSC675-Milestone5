package main

import "time"

type Citizen struct {
	ID      int
	Name    string
	SSN     string
	DOB     time.Time
	Address string
}

type PopularElectionWinner struct {
	Name          string
	NumberOfVotes int
	Margin        int
}
