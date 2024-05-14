package main

import (
	"fmt"
	"log"

	"github.com/bwmarrin/discordgo"
)

var (
	integerOptionMinValue          = 1.0
	dmPermission                   = false
	defaultMemberPermissions int64 = discordgo.PermissionManageServer

	commands = []*discordgo.ApplicationCommand{
		{
			Name:        "hello",
			Description: "Say hello to someone!",
			Options: []*discordgo.ApplicationCommandOption{
				{
					Type:        discordgo.ApplicationCommandOptionString,
					Name:        "name",
					Description: "Name of person to greet",
					Required:    false,
				},
			},
		},
		{
			Name:        "citizens",
			Description: "List all citizens in this voting system",
		},
	}

	commandHandlers = map[string]func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App){
		"hello": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			options := i.ApplicationCommandData().Options

			optionMap := make(map[string]*discordgo.ApplicationCommandInteractionDataOption, len(options))
			for _, opt := range options {
				optionMap[opt.Name] = opt
			}

			name := "world"

			if option, ok := optionMap["name"]; ok {
				name = option.StringValue()
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Content: fmt.Sprintf("Hello %v!", name),
				},
			})
		},
		"citizens": func(s *discordgo.Session, i *discordgo.InteractionCreate, a *App) {
			citizens, err := a.AllCitizens()
			if err != nil {
				log.Printf(err.Error())
				s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
					Type: discordgo.InteractionResponseChannelMessageWithSource,
					Data: &discordgo.InteractionResponseData{
						Content: "Unable to retreive citizens list. Try again later.",
					},
				})
				return
			}

			s.InteractionRespond(i.Interaction, &discordgo.InteractionResponse{
				Type: discordgo.InteractionResponseChannelMessageWithSource,
				Data: &discordgo.InteractionResponseData{
					Content: fmt.Sprint(citizens),
				},
			})
		},
	}
)
