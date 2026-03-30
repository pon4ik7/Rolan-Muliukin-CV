package middleware

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestRecoveryMiddleware_ConvertsPanicTo500(t *testing.T) {
	next := http.HandlerFunc(func(http.ResponseWriter, *http.Request) {
		panic("unexpected crash")
	})

	handler := Recovery(next)
	req := httptest.NewRequest(http.MethodGet, "/api/v1/profile", nil)
	rec := httptest.NewRecorder()

	handler.ServeHTTP(rec, req)

	if rec.Code != http.StatusInternalServerError {
		t.Fatalf("expected 500, got %d", rec.Code)
	}
	body := rec.Body.String()
	if !strings.Contains(body, `"status":"error"`) {
		t.Fatalf("expected error JSON body, got %q", body)
	}
	if !strings.Contains(body, "internal server error") {
		t.Fatalf("expected internal error message, got %q", body)
	}
}
