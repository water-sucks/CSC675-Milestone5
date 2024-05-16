package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/go-sql-driver/mysql"
)

func InitDB() *sql.DB {
	cfg := mysql.Config{
		User:      os.Getenv("DB_USER"),
		Passwd:    os.Getenv("DB_PASSWORD"),
		Addr:      os.Getenv("DB_HOST"),
		DBName:    os.Getenv("DB_NAME"),
		ParseTime: true,
	}

	db, err := sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal("error opening database:", err)
	}

	return db
}

func (a *App) Patriots() ([]Patriot, error) {
	var citizens []Patriot

	rows, err := a.db.Query("CALL Patriots()")
	if err != nil {
		return nil, fmt.Errorf("Patriots: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var citizen Patriot
		if err := rows.Scan(&citizen.ID, &citizen.Name, &citizen.NumberOfVotes); err != nil {
			return nil, fmt.Errorf("Patriots: %v", err)
		}
		citizens = append(citizens, citizen)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("Patriots: %v", err)
	}

	return citizens, nil
}

func (a *App) PopularElectionWinner(electionID int) (*PopularElectionWinner, error) {
	var winner PopularElectionWinner

	err := a.db.QueryRow("CALL PopularElectionWinner(?)", electionID).Scan(&winner.Name, &winner.NumberOfVotes, &winner.Margin)

	switch {
	case err == sql.ErrNoRows:
		return nil, nil
	case err != nil:
		return nil, fmt.Errorf("PopularElectionWinner: %v", err)
	default:
		return &winner, nil
	}
}

func (a *App) InitiativePassed(electionID int) (*InitiativePassedResult, error) {
	var result InitiativePassedResult

	err := a.db.QueryRow("CALL InitiativePassed(?)", electionID).Scan(&result.Name, &result.Passed, &result.RequiredNumberOfVotes, &result.NumberOfVotes)
	if err != nil {
		return nil, fmt.Errorf("InitiativePassedResult: %v", err)
	}

	if result.RequiredNumberOfVotes == 0 {
		return nil, nil
	}

	return &result, nil
}

func (a *App) PartyPopularity() ([]PartyPopularityResult, error) {
	var parties []PartyPopularityResult

	rows, err := a.db.Query("CALL PartyPopularity()")
	if err != nil {
		return nil, fmt.Errorf("PartyPopularity: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var party PartyPopularityResult
		if err := rows.Scan(&party.AffiliationCount, &party.Name); err != nil {
			return nil, fmt.Errorf("PartyPopularity: %v", err)
		}
		parties = append(parties, party)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("PartyPopularity: %v", err)
	}

	return parties, nil
}

func (a *App) CandidateElectionHistory() ([]CandidateHistoryResult, error) {
	var candidates []CandidateHistoryResult

	rows, err := a.db.Query("CALL CandidateHistory()")
	if err != nil {
		return nil, fmt.Errorf("CandidateElectionHistory: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var candidate CandidateHistoryResult
		if err := rows.Scan(&candidate.ID, &candidate.Name, &candidate.NumberOfElections); err != nil {
			return nil, fmt.Errorf("CandidateElectionHistory: %v", err)
		}
		candidates = append(candidates, candidate)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("CandidateElectionHistory: %v", err)
	}

	return candidates, nil
}

func (a *App) ElectionHistory() ([]ElectionHistoryResult, error) {
	var elections []ElectionHistoryResult

	rows, err := a.db.Query("CALL FindElections()")
	if err != nil {
		return nil, fmt.Errorf("ElectionHistory: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var election ElectionHistoryResult
		if err := rows.Scan(&election.Name, &election.Description, &election.Deadline, &election.DeadlinePassed, &election.ElectionType); err != nil {
			return nil, fmt.Errorf("ElectionHistory: %v", err)
		}
		elections = append(elections, election)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("ElectionHistory: %v", err)
	}

	return elections, nil
}

func (a *App) ElectionTurnout(electionID int, t ElectionType) (*ElectionTurnoutResult, error) {
	var result ElectionTurnoutResult

	var queryString string
	switch t {
	case PopularElection:
		queryString = "CALL PopularElectionTurnout(?)"
	case ElectoralElection:
		queryString = "CALL ElectoralElectionTurnout(?)"
	case Referendum:
		queryString = "CALL ReferendumTurnout(?)"
	case Initiative:
		queryString = "CALL InitiativeTurnout(?)"
	default:
		log.Panicf("ElectionTurnout: incorrect value %v provided for election type", electionID)
	}

	err := a.db.QueryRow(queryString, electionID).Scan(&result.Name, &result.Turnout)
	switch {
	case err == sql.ErrNoRows:
		return nil, nil
	case err != nil:
		return nil, fmt.Errorf("ElectionTurnout: %v", err)
	default:
		return &result, nil
	}
}

func (a *App) CitizenCandidateVotes(citizenID int) ([]CitizenVoteResult, error) {
	var votes []CitizenVoteResult

	rows, err := a.db.Query("CALL CitizenCandidateVotes(?)", citizenID)
	if err != nil {
		return nil, fmt.Errorf("CitizenCandidateVotes: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var vote CitizenVoteResult
		if err := rows.Scan(&vote.ElectionName, &vote.CandidateName, &vote.CastTime); err != nil {
			return nil, fmt.Errorf("CitizenCandidateVotes: %v", err)
		}
		votes = append(votes, vote)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("CitizenCandidateVotes: %v", err)
	}

	return votes, nil
}

func (a *App) DeleteCitizen(citizenID int) error {
	_, err := a.db.Query("Call RemoveCitizen(?)", citizenID)
	if err != nil {
		return fmt.Errorf("DeleteCitizen: %v", err)
	}
	return nil
}

func (a *App) DeleteSuspiciousVotes() error {
	_, err := a.db.Query("CALL RemoveSuspiciousVotes()")
	if err != nil {
		return fmt.Errorf("DeleteSuspiciousVotes: %v", err)
	}
	return nil
}
