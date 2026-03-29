package handler

import (
	"encoding/json"
	"net/http"
)

type apiResponse struct {
	Status string    `json:"status"`
	Data   any       `json:"data,omitempty"`
	Error  *apiError `json:"error,omitempty"`
}

type apiError struct {
	Message string `json:"message"`
}

func writeSuccess(w http.ResponseWriter, code int, payload any) {
	writeJSON(w, code, apiResponse{
		Status: "success",
		Data:   payload,
	})
}

func writeError(w http.ResponseWriter, code int, message string) {
	writeJSON(w, code, apiResponse{
		Status: "error",
		Error:  &apiError{Message: message},
	})
}

func writeJSON(w http.ResponseWriter, code int, payload apiResponse) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)

	if err := json.NewEncoder(w).Encode(payload); err != nil {
		http.Error(w, `{"status":"error","error":{"message":"failed to encode response"}}`, http.StatusInternalServerError)
	}
}
