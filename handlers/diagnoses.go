package handlers

import (
	"database/sql"
	"net/http"
	"github.com/labstack/echo/v4"
	"lp-api/config"
	"lp-api/models"
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

	// Get the headers
	headerRows, err := config.DB.Query("SELECT id, title, diagnosis_id FROM diagnoses_headers WHERE diagnosis_id = ?", diagnosisID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching headers", "error": err.Error()})
	}
	defer headerRows.Close()

	var headers []models.DiagnosisHeader
	for headerRows.Next() {
		var header models.DiagnosisHeader
		err := headerRows.Scan(&header.ID, &header.Title, &header.DiagnosisID)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error scanning header", "error": err.Error()})
		}

		// Get the questions for each header
		questionsRows, err := config.DB.Query("SELECT id, title, weighting, type, is_valid, diagnosis_id, diagnosis_header_id FROM diagnoses_questions WHERE diagnosis_header_id = ?", header.ID)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching questions", "error": err.Error()})
		}
		defer questionsRows.Close()

		var questions []models.DiagnosisQuestion
		for questionsRows.Next() {
			var question models.DiagnosisQuestion
			err := questionsRows.Scan(&question.ID, &question.Title, &question.Weighting, &question.Type, &question.IsValid, &question.DiagnosisID, &question.DiagnosisHeaderID)
			if err != nil {
				return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error scanning question", "error": err.Error()})
			}

			// Get the choices for each question
			choicesRows, err := config.DB.Query("SELECT id, title, point, is_valid, diagnosis_question_id FROM diagnoses_questions_choices WHERE diagnosis_question_id = ?", question.ID)
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

		header.Questions = questions
		headers = append(headers, header)
	}

	diagnosis.Headers = headers

	return c.JSON(http.StatusOK, diagnosis)
}
