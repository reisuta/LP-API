START TRANSACTION;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS diagnoses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS diagnoses_headers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  diagnosis_id INT,
  title VARCHAR(255) NOT NULL,
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS diagnoses_questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  weighting INT,
  type VARCHAR(255) NOT NULL,
  is_valid BOOLEAN,
  diagnosis_id INT,
  diagnosis_header_id INT,
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses(id) ON DELETE CASCADE,
  FOREIGN KEY (diagnosis_header_id) REFERENCES diagnoses_headers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS diagnoses_questions_choices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  point INT,
  is_valid BOOLEAN,
  diagnosis_question_id INT,
  FOREIGN KEY (diagnosis_question_id) REFERENCES diagnoses_questions(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS diagnoses_answers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  point INT,
  diagnosis_question_id INT,
  user_id INT,
  FOREIGN KEY (diagnosis_question_id) REFERENCES diagnoses_questions(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

COMMIT;
