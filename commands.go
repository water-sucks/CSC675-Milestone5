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
				sendMessage(s, i.Interaction, "Unable to retreive citizens list. Try again later.")
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
									Name:  "Name",
									Value: citizenNames,
								},
								{
									Name:  "# Votes",
									Value: citizenVotes,
								},
							},
						},
					},
				},
			})
		},
	}
)
