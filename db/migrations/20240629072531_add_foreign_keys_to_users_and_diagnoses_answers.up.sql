ALTER TABLE diagnoses_answers
ADD COLUMN evaluation_id INT;

ALTER TABLE diagnoses_answers
ADD CONSTRAINT fk_diagnoses_answers_evaluation_id
FOREIGN KEY (evaluation_id) REFERENCES evaluations(id) ON DELETE CASCADE;

ALTER TABLE evaluations
ADD COLUMN user_id INT;

ALTER TABLE evaluations
ADD CONSTRAINT fk_evaluations_user_id
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
