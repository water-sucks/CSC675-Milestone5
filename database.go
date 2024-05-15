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

	err := a.db.QueryRow("CALL PopularElectionWinner(?)", electionID).Scan(&winner.Name, &winner.Margin, &winner.NumberOfVotes)

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
