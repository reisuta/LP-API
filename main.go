package main

import (
	"lp-api/config"
	"lp-api/handlers"
	"github.com/labstack/echo/v4"
	"github.com/joho/godotenv"
	"log"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %s\n", err.Error())
	}

	config.InitDB()
  config.MigrateDB()
  config.SeedData()

	e := echo.New()

  e.POST("/save", handlers.SaveData)
  e.GET("/diagnosis/:id", handlers.GetDiagnosis)

	e.Logger.Fatal(e.Start(":8080"))
}
