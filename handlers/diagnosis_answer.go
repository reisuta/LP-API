package handlers

import (
	"net/http"
	"lp-api/config"

	"github.com/labstack/echo/v4"
)

type DiagnosisAnswerRequest struct {
	Title      string `json:"title"`
	Point      int    `json:"point"`
	Weighting  int    `json:"weighting"`
	QuestionID int    `json:"question_id"`
	ChoiceID   int    `json:"choice_id"`
}

// SaveDiagnosisAnswers saves multiple diagnosis answers to the database
func SaveDiagnosisAnswer(c echo.Context) error {
	var reqs []DiagnosisAnswerRequest
	if err := c.Bind(&reqs); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid input", "error": err.Error()})
	}

	// 0で初期化 user_idは後にログイン機能を実装してから修正する
	result, err := config.DB.Exec("INSERT INTO evaluations (score, user_id) VALUES (?, ?)", 0, 1)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error saving evaluation", "error": err.Error()})
	}

	evaluationID, err := result.LastInsertId()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error getting evaluation ID", "error": err.Error()})
	}

	totalScore := 0

	// Save each diagnosis answer with the evaluation ID
	for _, req := range reqs {
		score := req.Point * req.Weighting
		totalScore += score

		_, err := config.DB.Exec(
			"INSERT INTO diagnoses_answers (title, point, diagnosis_question_id, evaluation_id) VALUES (?, ?, ?, ?)",
			req.Title, score, req.QuestionID, evaluationID,
		)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error saving diagnosis answer", "error": err.Error()})
		}
	}

	// Update the score in the evaluations table
	_, err = config.DB.Exec("UPDATE evaluations SET score = ? WHERE id = ?", totalScore, evaluationID)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error updating evaluation score", "error": err.Error()})
	}

	return c.JSON(http.StatusOK, map[string]interface{}{"message": "Diagnosis answers saved successfully", "total_score": totalScore})
}
