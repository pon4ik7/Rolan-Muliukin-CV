package middleware

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestResolveOrigin(t *testing.T) {
	tests := []struct {
		name    string
		origin  string
		allowed []string
		want    string
	}{
		{
			name:    "empty allowed",
			origin:  "https://app.example",
			allowed: nil,
			want:    "",
		},
		{
			name:    "wildcard",
			origin:  "https://app.example",
			allowed: []string{"*"},
			want:    "*",
		},
		{
			name:    "exact match",
			origin:  "https://app.example",
			allowed: []string{"https://app.example"},
			want:    "https://app.example",
		},
		{
			name:    "origin not allowed",
			origin:  "https://app.example",
			allowed: []string{"https://other.example"},
			want:    "",
		},
		{
			name:    "empty origin is rejected",
			origin:  "",
			allowed: []string{"https://app.example"},
			want:    "",
		},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			if got := resolveOrigin(tt.origin, tt.allowed); got != tt.want {
				t.Fatalf("unexpected resolved origin: got=%q want=%q", got, tt.want)
			}
		})
	}
}

func TestCORSMiddleware_PreflightAndRegularRequest(t *testing.T) {
	t.Run("preflight short-circuits with 204", func(t *testing.T) {
		called := false
		next := http.HandlerFunc(func(http.ResponseWriter, *http.Request) {
			called = true
		})

		handler := CORS([]string{"https://app.example"})(next)
		req := httptest.NewRequest(http.MethodOptions, "/api/v1/profile", nil)
		req.Header.Set("Origin", "https://app.example")
		rec := httptest.NewRecorder()

		handler.ServeHTTP(rec, req)

		if called {
			t.Fatal("expected preflight request to not reach next handler")
		}
		if rec.Code != http.StatusNoContent {
			t.Fatalf("expected 204 for preflight, got %d", rec.Code)
		}
		if got := rec.Header().Get("Access-Control-Allow-Origin"); got != "https://app.example" {
			t.Fatalf("unexpected allow-origin header: %q", got)
		}
	})

	t.Run("regular request keeps pipeline and sets shared headers", func(t *testing.T) {
		next := http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
			w.WriteHeader(http.StatusAccepted)
		})
		handler := CORS([]string{"*"})(next)

		req := httptest.NewRequest(http.MethodGet, "/api/v1/profile", nil)
		req.Header.Set("Origin", "https://app.example")
		rec := httptest.NewRecorder()

		handler.ServeHTTP(rec, req)

		if rec.Code != http.StatusAccepted {
			t.Fatalf("unexpected status code: %d", rec.Code)
		}
		if got := rec.Header().Get("Access-Control-Allow-Origin"); got != "*" {
			t.Fatalf("unexpected allow-origin header: %q", got)
		}
		if got := rec.Header().Get("Access-Control-Allow-Methods"); got != "GET, OPTIONS" {
			t.Fatalf("unexpected allow-methods header: %q", got)
		}
	})
}
