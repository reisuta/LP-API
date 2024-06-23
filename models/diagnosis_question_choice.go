package models

type DiagnosisQuestionChoice struct {
	ID         int    `json:"id"`
	Title      string `json:"title"`
	Point      int    `json:"point"`
	IsValid    bool   `json:"is_valid"`
	QuestionID int    `json:"question_id"`
}
