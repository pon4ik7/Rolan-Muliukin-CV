package middleware

import (
	"bytes"
	"log"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestLoggingMiddleware_RecordsRequestMethodPathAndStatus(t *testing.T) {
	var logBuffer bytes.Buffer
	originalWriter := log.Writer()
	log.SetOutput(&logBuffer)
	t.Cleanup(func() {
		log.SetOutput(originalWriter)
	})

	next := http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusCreated)
	})

	handler := Logging(next)
	req := httptest.NewRequest(http.MethodPost, "/api/v1/projects", nil)
	rec := httptest.NewRecorder()

	handler.ServeHTTP(rec, req)

	if rec.Code != http.StatusCreated {
		t.Fatalf("expected status 201, got %d", rec.Code)
	}

	logLine := logBuffer.String()
	if !strings.Contains(logLine, "POST /api/v1/projects 201") {
		t.Fatalf("unexpected log line: %q", logLine)
	}
}

func TestResponseRecorder_DefaultStatusCodeIs200WhenWriteHeaderNotCalled(t *testing.T) {
	var logBuffer bytes.Buffer
	originalWriter := log.Writer()
	log.SetOutput(&logBuffer)
	t.Cleanup(func() {
		log.SetOutput(originalWriter)
	})

	next := http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("ok"))
	})

	handler := Logging(next)
	req := httptest.NewRequest(http.MethodGet, "/api/v1/health", nil)
	rec := httptest.NewRecorder()

	handler.ServeHTTP(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("expected status 200, got %d", rec.Code)
	}

	logLine := logBuffer.String()
	if !strings.Contains(logLine, "GET /api/v1/health 200") {
		t.Fatalf("unexpected log line: %q", logLine)
	}
}
