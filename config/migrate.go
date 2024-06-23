package config

import (
	"log"
)

func MigrateDB() {
	query := `
	CREATE TABLE IF NOT EXISTS users (
		id INT AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(255) NOT NULL,
		email VARCHAR(255) NOT NULL,
    UNIQUE (email)
	);
	`

	_, err := DB.Exec(query)
	if err != nil {
		log.Fatalf("Error creating table: %s\n", err.Error())
	} else {
		log.Println("Table 'users' created or already exists.")
	}
}
