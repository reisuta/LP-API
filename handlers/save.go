package handlers

import (
	"lp-api/config"
	"net/http"
	"github.com/labstack/echo/v4"
)

type SaveRequest struct {
	Name  string `form:"name"  json:"name"`
	Email string `form:"email" json:"email"`
}

func SaveData(c echo.Context) error {
	req := new(SaveRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid input"})
	}

	// Prepare the SQL statement
	stmt, err := config.DB.Prepare("INSERT INTO users (name, email) VALUES (?, ?)")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error preparing SQL statement"})
	}
	defer stmt.Close()

	// Execute the SQL statement
	_, err = stmt.Exec(req.Name, req.Email)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Error executing SQL statement"})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Data saved successfully"})
}
