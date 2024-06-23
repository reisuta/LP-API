package config

import (
	"log"
)

func MigrateDB() {
	queries := []string{
		`CREATE TABLE IF NOT EXISTS users (
			id INT AUTO_INCREMENT PRIMARY KEY,
			name VARCHAR(255) NOT NULL,
			email VARCHAR(255) NOT NULL,
			UNIQUE (email)
		);`,

		`CREATE TABLE IF NOT EXISTS diagnoses (
			id INT AUTO_INCREMENT PRIMARY KEY,
			title VARCHAR(255) NOT NULL
		);`,

		`CREATE TABLE IF NOT EXISTS diagnoses_questions (
			id INT AUTO_INCREMENT PRIMARY KEY,
			title VARCHAR(255) NOT NULL,
			weighting INT,
			is_valid BOOLEAN,
			diagnosis_id INT,
			FOREIGN KEY (diagnosis_id) REFERENCES diagnoses(id) ON DELETE CASCADE
		);`,

		`CREATE TABLE IF NOT EXISTS diagnoses_questions_choices (
			id INT AUTO_INCREMENT PRIMARY KEY,
			title VARCHAR(255) NOT NULL,
			point INT,
			is_valid BOOLEAN,
			question_id INT,
			FOREIGN KEY (question_id) REFERENCES diagnoses_questions(id) ON DELETE CASCADE
		);`,

		`CREATE TABLE IF NOT EXISTS diagnoses_answers (
			id INT AUTO_INCREMENT PRIMARY KEY,
			title VARCHAR(255) NOT NULL,
			point INT,
			question_id INT,
			FOREIGN KEY (question_id) REFERENCES diagnoses_questions(id) ON DELETE CASCADE
		);`,
	}

	for _, query := range queries {
		_, err := DB.Exec(query)
		if err != nil {
			log.Fatalf("Error creating table: %s\n", err.Error())
		}
	}

	log.Println("Tables created or already exist.")
}
