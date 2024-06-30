package handlers

import (
	"database/sql"
	"net/http"

	"github.com/labstack/echo/v4"
	"lp-api/config"
	"lp-api/models"
)

// GetEvaluation retrieves an evaluation by its ID.
func GetEvaluation(c echo.Context) error {
	evaluationID := c.Param("id")
	var evaluation models.Evaluation

	// Fetch the evaluation from the database
	err := config.DB.QueryRow("SELECT id, user_id, score FROM evaluations WHERE id = ?", evaluationID).Scan(&evaluation.ID, &evaluation.UserID, &evaluation.Score)
	if err != nil {
		if err == sql.ErrNoRows {
			return c.JSON(http.StatusNotFound, map[string]string{"message": "Evaluation not found"})
		}
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error fetching evaluation", "error": err.Error()})
	}

	return c.JSON(http.StatusOK, evaluation)
}
