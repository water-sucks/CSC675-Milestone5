package main

import "time"

type Citizen struct {
	ID      int64
	Name    string
	SSN     string
	DOB     time.Time
	Address string
}
