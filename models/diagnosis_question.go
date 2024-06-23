package models

type DiagnosisQuestion struct {
	ID          int                       `json:"id"`
	Title       string                    `json:"title"`
	Weighting   int                       `json:"weighting"`
	IsValid     bool                      `json:"is_valid"`
	DiagnosisID int                       `json:"diagnosis_id"`
	Choices     []DiagnosisQuestionChoice `json:"choices"`
}
