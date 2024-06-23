package handlers

import (
	"database/sql"
	"lp-api/config"
	"lp-api/models"
	"net/http"

	"github.com/labstack/echo/v4"
)

func GetDiagnosis(c echo.Context) error {
	diagnosisID := c.Param("id")
	var diagnosis models.Diagnosis

	// Get the diagnosis
	err := config.DB.QueryRow("SELECT id, title FROM diagnoses WHERE id = ?", diagnosisID).Scan(&diagnosis.ID, &diagnosis.Title)
	if err != nil {
		if err == sql.ErrNoRows {
			return c.JSON(http.StatusNotFound, map[string]string{"message": "Diagnosis not found"})
		}
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching diagnosis", "error": err.Error()})
	}

	// Get the questions
	questionsRows, err := config.DB.Query("SELECT id, title, weighting, is_valid, diagnosis_id FROM diagnoses_questions WHERE diagnosis_id = ?", diagnosisID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching questions", "error": err.Error()})
	}
	defer questionsRows.Close()

	var questions []models.DiagnosisQuestion
	for questionsRows.Next() {
		var question models.DiagnosisQuestion
		err := questionsRows.Scan(&question.ID, &question.Title, &question.Weighting, &question.IsValid, &question.DiagnosisID)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error scanning question", "error": err.Error()})
		}

		// Get the choices for each question
		choicesRows, err := config.DB.Query("SELECT id, title, point, is_valid, question_id FROM diagnoses_questions_choices WHERE question_id = ?", question.ID)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching choices", "error": err.Error()})
		}
		defer choicesRows.Close()

		var choices []models.DiagnosisQuestionChoice
		for choicesRows.Next() {
			var choice models.DiagnosisQuestionChoice
			err := choicesRows.Scan(&choice.ID, &choice.Title, &choice.Point, &choice.IsValid, &choice.QuestionID)
			if err != nil {
				return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error scanning choice", "error": err.Error()})
			}
			choices = append(choices, choice)
		}

		question.Choices = choices
		questions = append(questions, question)
	}

	diagnosis.Questions = questions

	return c.JSON(http.StatusOK, diagnosis)
}
