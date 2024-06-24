package handlers

import (
	"net/http"
	"lp-api/config"

	"github.com/labstack/echo/v4"
)

type DiagnosisAnswerRequest struct {
	Title      string `json:"title"`
	Point      int    `json:"point"`
	QuestionID int    `json:"question_id"`
}

// SaveDiagnosisAnswer saves a diagnosis answer to the database
func SaveDiagnosisAnswer(c echo.Context) error {
	var req DiagnosisAnswerRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid input"})
	}

	_, err := config.DB.Exec(
		"INSERT INTO diagnoses_answers (title, point, question_id) VALUES (?, ?, ?)",
		req.Title, req.Point, req.QuestionID,
	)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error saving diagnosis answer", "error": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Diagnosis answer saved successfully"})
}
