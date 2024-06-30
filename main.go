package main

import (
	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"log"
	"lp-api/config"
	"lp-api/handlers"
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
	e.GET("/evaluation/:id", handlers.GetEvaluation)

	e.Logger.Fatal(e.Start(":8080"))
}
