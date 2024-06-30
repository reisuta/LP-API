package config

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

var DB *sql.DB

func InitDB() {
	var err error
	dataSourceName := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s",
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_NAME"),
	)

	for i := 0; i < 6; i++ {
		DB, err = sql.Open("mysql", dataSourceName)
		if err == nil {
			err = DB.Ping()
			if err == nil {
				log.Println("Connected to the database")
				return
			}
		}
		log.Printf("Failed to connect to database. Retrying in 4 seconds... (%d/10)\n", i+1)
		time.Sleep(4 * time.Second)
	}

	log.Fatalf("Error connecting to the database: %s\n", err.Error())
}
