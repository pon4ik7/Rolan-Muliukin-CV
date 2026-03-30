package handler

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestWriteSuccess_FormatsJSONPayload(t *testing.T) {
	rec := httptest.NewRecorder()

	writeSuccess(rec, http.StatusCreated, map[string]any{"id": "p1"})

	if rec.Code != http.StatusCreated {
		t.Fatalf("expected 201, got %d", rec.Code)
	}
	if got := rec.Header().Get("Content-Type"); got != "application/json" {
		t.Fatalf("expected json content type, got %q", got)
	}

	var body struct {
		Status string         `json:"status"`
		Data   map[string]any `json:"data"`
	}
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("invalid JSON: %v", err)
	}
	if body.Status != "success" {
		t.Fatalf("expected success status, got %q", body.Status)
	}
	if body.Data["id"] != "p1" {
		t.Fatalf("unexpected payload data: %#v", body.Data)
	}
}

func TestWriteError_FormatsErrorPayload(t *testing.T) {
	rec := httptest.NewRecorder()

	writeError(rec, http.StatusBadRequest, "bad request")

	if rec.Code != http.StatusBadRequest {
		t.Fatalf("expected 400, got %d", rec.Code)
	}
	if got := rec.Header().Get("Content-Type"); got != "application/json" {
		t.Fatalf("expected json content type, got %q", got)
	}

	var body struct {
		Status string `json:"status"`
		Error  struct {
			Message string `json:"message"`
		} `json:"error"`
	}
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("invalid JSON: %v", err)
	}
	if body.Status != "error" {
		t.Fatalf("expected error status, got %q", body.Status)
	}
	if body.Error.Message != "bad request" {
		t.Fatalf("unexpected error message: %q", body.Error.Message)
	}
}
