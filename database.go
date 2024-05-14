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
		User:   os.Getenv("DB_USER"),
		Passwd: os.Getenv("DB_PASSWORD"),
		Addr:   os.Getenv("DB_HOST"),
		DBName: os.Getenv("DB_NAME"),
	}

	db, err := sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal("error opening database:", err)
	}

	return db
}

func (a *App) AllCitizens() ([]Citizen, error) {
	var citizens []Citizen

	rows, err := a.db.Query("SELECT * FROM citizens")
	if err != nil {
		return nil, fmt.Errorf("AllCitizens: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var citizen Citizen
		if err := rows.Scan(&citizen.ID, &citizen.Name, &citizen.SSN, &citizen.DOB, &citizen.Address); err != nil {
			return nil, fmt.Errorf("AllCitizens: %v", err)
		}
		citizens = append(citizens, citizen)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("AllCitizens: %v", err)
	}

	return []Citizen{}, nil
}
