package models

type Diagnosis struct {
	ID       int                `json:"id"`
	Title    string             `json:"title"`
	Questions []DiagnosisQuestion `json:"questions"`
}
