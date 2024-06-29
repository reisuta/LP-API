package main

import (
	"lp-api/config"
	"lp-api/handlers"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/joho/godotenv"
	"log"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %s\n", err.Error())
	}

	config.InitDB()

	e := echo.New()

  e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"http://localhost:3001"},
		AllowMethods: []string{echo.GET, echo.POST, echo.PUT, echo.DELETE},
	}))

  e.GET("/diagnosis/:id", handlers.GetDiagnosis)
  e.POST("/diagnosis_answer", handlers.SaveDiagnosisAnswer)

	e.Logger.Fatal(e.Start(":8080"))
}
