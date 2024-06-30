package models

type Diagnosis struct {
	ID        int                 `json:"id"`
	Title     string              `json:"title"`
	Headers   []DiagnosisHeader   `json:"headers"`
	Questions []DiagnosisQuestion `json:"questions"`
}
