package models

type DiagnosisHeader struct {
	ID       int                `json:"id"`
	Title    string             `json:"title"`
	DiagnosisID int               `json:"diagnosis_id"`
	Questions []DiagnosisQuestion `json:"questions"`
}
