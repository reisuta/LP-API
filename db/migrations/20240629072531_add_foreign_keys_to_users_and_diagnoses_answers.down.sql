ALTER TABLE diagnoses_answers
DROP CONSTRAINT fk_diagnoses_answers_evaluation_id;

ALTER TABLE diagnoses_answers
DROP COLUMN evaluation_id;

ALTER TABLE evaluations
DROP CONSTRAINT fk_evaluations_user_id;

ALTER TABLE evaluations
DROP COLUMN user_id;
