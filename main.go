package main

import (
	"log"
	"os"
	"os/signal"

	"github.com/bwmarrin/discordgo"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("error loading .env: %v", err)
	}

	token := os.Getenv("DISCORD_TOKEN")
	if token == "" {
		log.Fatalln("DISCORD_TOKEN not set")
	}

	db := InitDB()
	app := App{
		db: db,
	}

	s, err := discordgo.New("Bot " + token)
	if err != nil {
		log.Fatalf("invalid bot parameters: %v", err)
	}

	s.AddHandler(func(s *discordgo.Session, i *discordgo.InteractionCreate) {
		if h, ok := commandHandlers[i.ApplicationCommandData().Name]; ok {
			h(s, i, &app)
		}
	})

	err = s.Open()
	if err != nil {
		log.Fatalf("error opening session: %v", err)
	}

	log.Println("adding commands")
	registeredCommands := make([]*discordgo.ApplicationCommand, len(commands))
	for i, v := range commands {
		cmd, err := s.ApplicationCommandCreate(s.State.User.ID, "", v)
		if err != nil {
			log.Panicf("error creating '%v' command: %v", v.Name, err)
		}
		registeredCommands[i] = cmd
		log.Printf("created '%v' command", v.Name)
	}

	defer s.Close()

	stop := make(chan os.Signal, 1)
	signal.Notify(stop, os.Interrupt)
	log.Println("press ctrl+c to exit")
	<-stop

	log.Println("removing commands")
	for _, v := range registeredCommands {
		err := s.ApplicationCommandDelete(s.State.User.ID, "", v.ID)
		if err != nil {
			log.Panicf("error deleting '%v' command: %v", v.Name, err)
		}
		log.Printf("removed '%v' command", v.Name)
	}

	log.Println("shutting down")
}
