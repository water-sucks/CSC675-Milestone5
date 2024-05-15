package main

import (
	"fmt"
	"log"

	"github.com/bwmarrin/discordgo"
)

func sendMessage(s *discordgo.Session, i *discordgo.Interaction, message string) {
	s.InteractionRespond(i, &discordgo.InteractionResponse{
		Type: discordgo.InteractionResponseChannelMessageWithSource,
		Data: &discordgo.InteractionResponseData{
			Content: message,
		},
	})
}

var (
	integerOptionMinValue          = 1.0
	dmPermission                   = false
	defaultMemberPermissions int64 = discordgo.PermissionManageServer

	commands = []*discordgo.ApplicationCommand{
		{
			Name:        "find-election-winner",
			Description: "Find the winner of an election",
			Options: []*discordgo.ApplicationCommandOption{
				{
					Type:        discordgo.ApplicationCommandOptionString,
					Name:        "election-type",
					Description: "Type of election (popular | electoral | referendum | initiative)",
					Required:    true,
				},
				{
					Type:        discordgo.ApplicationCommandOptionInteger,
					Name:        "election-id",
					Description: "ID of election to find winner for",
					Required:    true,
				},
			},
		},
		{
			Name:        "patriots",
			Description: "List all citizens in this voting system that have 3 or more votes",
		},
		{
			Name:        "party-popularity",
			Description: "Find the popularity of each political party by affiliation numbers",
		},
		{
			Name:        "find-elections",
			Description: "List all elections and if they are available to vote in",
		},
		{
			Name:        "candidate-election-history",
			Description: "Find the number of elections this candidate has ran in",
		},
		{
			Name:        "find-election-turnout",
			Description: "Find the total percentage of turnout of an election",
			Options: []*discordgo.ApplicationCommandOption{
				{
					Type:        discordgo.ApplicationCommandOptionString,
					Name:        "election-type",
					Description: "Type of election (popular | electoral | referendum | initiative)",
					Required:    true,
				},
				{
					Type:        discordgo.ApplicationCommandOptionInteger,
					Name:        "election-id",
					Description: "ID of election to find winner for",
					Required:    true,
				},
			},
		},
	}

	commandHandlers = map[string]func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App){
		"find-election-winner": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			options := i.ApplicationCommandData().Options

			optionMap := make(map[string]*discordgo.ApplicationCommandInteractionDataOption, len(options))
			for _, opt := range options {
				optionMap[opt.Name] = opt
			}

			electionID := int(optionMap["election-id"].IntValue())
			electionType := optionMap["election-type"].StringValue()

			if electionType == "popular" {
				winner, err := a.PopularElectionWinner(electionID)
				if err != nil {
					log.Printf(err.Error())
					sendMessage(s, i.Interaction, "An internal error has occurred. Try again later.")
					return
				}
				if winner == nil {
					sendMessage(s, i.Interaction, "No results for this election at this time.")
					return
				}

				sendMessage(s, i.Interaction, fmt.Sprintf("The winner of this election is %v, with %v votes and a %v%% margin.", winner.Name, winner.NumberOfVotes, winner.Margin))
			} else if electionType == "electoral" {
				sendMessage(s, i.Interaction, "Electoral elections not supported by this command currently.")
			} else if electionType == "referendum" {
				sendMessage(s, i.Interaction, "Referendums not supported by this command currently.")
			} else if electionType == "initiative" {
				result, err := a.InitiativePassed(electionID)
				if err != nil {
					log.Printf(err.Error())
					sendMessage(s, i.Interaction, "An internal error has occurred. Try again later.")
				}
				if result == nil {
					sendMessage(s, i.Interaction, "An election with this ID does not exist.")
					return
				}

				if result.Passed {
					sendMessage(s, i.Interaction, fmt.Sprintf("The initiative '%v' has passed with %v votes.", result.Name, result.NumberOfVotes))
				} else {
					sendMessage(s, i.Interaction, fmt.Sprintf("The initiative '%v' currently has %v votes; it needs %v to pass.", result.Name, result.NumberOfVotes, result.RequiredNumberOfVotes))
				}
			} else {
				sendMessage(s, i.Interaction, fmt.Sprintf("The specified election type %v is not supported.", electionType))
			}
		},

		"patriots": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			citizens, err := a.Patriots()
			if err != nil {
				log.Printf(err.Error())
				sendMessage(s, i.Interaction, "Unable to retreive party popularity list. Try again later.")
				return
			}

			citizenNames := ""
			citizenVotes := ""

			for _, v := range citizens {
				citizenNames += fmt.Sprintf("%s\n", v.Name)
				citizenVotes += fmt.Sprintf("%v\n", v.NumberOfVotes)
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Embeds: []*discordgo.MessageEmbed{
						{
							Title:       "Patriots",
							Description: "Citizens with 3+ Votes",
							Fields: []*discordgo.MessageEmbedField{
								{
									Name:   "Name",
									Value:  citizenNames,
									Inline: true,
								},
								{
									Name:   "# Votes",
									Value:  citizenVotes,
									Inline: true,
								},
							},
						},
					},
				},
			})
		},

		"party-popularity": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			parties, err := a.PartyPopularity()
			if err != nil {
				log.Printf(err.Error())
				sendMessage(s, i.Interaction, "Unable to retreive political party list. Try again later.")
				return
			}

			partyNames := ""
			affiliationCounts := ""

			for _, v := range parties {
				partyNames += fmt.Sprintf("%s\n", v.Name)
				affiliationCounts += fmt.Sprintf("%v\n", v.AffiliationCount)
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Embeds: []*discordgo.MessageEmbed{
						{
							Title:       "Party Popularity",
							Description: "Affiliation Counts For Political Parties",
							Fields: []*discordgo.MessageEmbedField{
								{
									Name:   "Name",
									Value:  partyNames,
									Inline: true,
								},
								{
									Name:   "# Affiliated Citizens",
									Value:  affiliationCounts,
									Inline: true,
								},
							},
						},
					},
				},
			})
		},

		"find-elections": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			elections, err := a.ElectionHistory()
			if err != nil {
				log.Printf(err.Error())
				sendMessage(s, i.Interaction, "Unable to retreive election list. Try again later.")
				return
			}

			electionNames := ""
			electionTypes := ""
			descriptions := ""
			deadlines := ""
			deadlinePassed := ""

			for _, v := range elections {
				electionNames += fmt.Sprintf("%s\n", v.Name)
				electionTypes += fmt.Sprintf("%s\n", v.ElectionType)
				descriptions += fmt.Sprintf("%v\n", v.Description)
				deadlines += fmt.Sprintf("%v\n", v.Deadline.Format("January 2, 2006"))
				deadlinePassed += fmt.Sprintf("%v\n", v.DeadlinePassed)
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Embeds: []*discordgo.MessageEmbed{
						{
							Title:       "Candidate Election History",
							Description: "Number of Elections Candidates Participated In",
							Fields: []*discordgo.MessageEmbedField{
								{
									Name:   "Name",
									Value:  electionNames,
									Inline: true,
								},
								{
									Name:   "Type",
									Value:  electionTypes,
									Inline: true,
								},
								{
									Name:   "Description",
									Value:  descriptions,
									Inline: true,
								},
								{
									Name:   "Voting Deadline",
									Value:  deadlines,
									Inline: true,
								},
								{
									Name:   "Can You Vote?",
									Value:  deadlinePassed,
									Inline: true,
								},
							},
						},
					},
				},
			})
		},

		"candidate-election-history": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			candidates, err := a.CandidateElectionHistory()
			if err != nil {
				log.Printf(err.Error())
				sendMessage(s, i.Interaction, "Unable to retreive candidates list. Try again later.")
				return
			}

			candidateNames := ""
			electionCounts := ""

			for _, v := range candidates {
				candidateNames += fmt.Sprintf("%s\n", v.Name)
				electionCounts += fmt.Sprintf("%v\n", v.NumberOfElections)
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Embeds: []*discordgo.MessageEmbed{
						{
							Title:       "Candidate Election History",
							Description: "Number of Elections Candidates Participated In",
							Fields: []*discordgo.MessageEmbedField{
								{
									Name:   "Name",
									Value:  candidateNames,
									Inline: true,
								},
								{
									Name:   "# Elections",
									Value:  electionCounts,
									Inline: true,
								},
							},
						},
					},
				},
			})
		},

		"find-election-turnout": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			options := i.ApplicationCommandData().Options

			optionMap := make(map[string]*discordgo.ApplicationCommandInteractionDataOption, len(options))
			for _, opt := range options {
				optionMap[opt.Name] = opt
			}

			electionID := int(optionMap["election-id"].IntValue())
			electionType := optionMap["election-type"].StringValue()

			var etype ElectionType
			switch electionType {
			case "popular":
				etype = PopularElection
			case "electoral":
				etype = ElectoralElection
			case "referendum":
				etype = Referendum
			case "initiative":
				etype = Initiative
			default:
				{
					sendMessage(s, i.Interaction, fmt.Sprintf("The specified election type %v is not supported.", electionType))
					return
				}
			}

			turnout, err := a.ElectionTurnout(electionID, etype)
			if err != nil {
				log.Printf(err.Error())
				sendMessage(s, i.Interaction, "An internal error has occurred. Try again later.")
				return
			}
			if turnout == nil {
				sendMessage(s, i.Interaction, "An election with this ID does not exist.")
				return
			}

			switch electionType {
			case "popular":
				sendMessage(s, i.Interaction, fmt.Sprintf("The turnout for this popular election '%v' was %v%% of registered voters.", turnout.Name, turnout.Turnout))
			case "electoral":
				sendMessage(s, i.Interaction, fmt.Sprintf("The turnout for this electoral election '%v' was %v%% of registered voters.", turnout.Name, turnout.Turnout))

			case "referendum":
				sendMessage(s, i.Interaction, fmt.Sprintf("The turnout for this referendum '%v' was %v%% of registered voters.", turnout.Name, turnout.Turnout))

			case "initiative":
				sendMessage(s, i.Interaction, fmt.Sprintf("The turnout for this initiative '%v' was %v%% of registered voters.", turnout.Name, turnout.Turnout))

			}
		},
	}
)
