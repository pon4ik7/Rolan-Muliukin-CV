package router

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"rolan-portfolio/backend/internal/config"
	"rolan-portfolio/backend/internal/handler"
	"rolan-portfolio/backend/internal/model"
)

type stubService struct{}

func (s *stubService) Profile(context.Context) (model.Profile, error) {
	return model.Profile{Name: "Rolan Muliukin"}, nil
}

func (s *stubService) Projects(context.Context) ([]model.Project, error) {
	return []model.Project{{ID: "p1", Name: "Project"}}, nil
}

func (s *stubService) Experience(context.Context) ([]model.Experience, error) {
	return []model.Experience{{ID: "e1", Title: "Backend Developer"}}, nil
}

func (s *stubService) Achievements(context.Context) ([]model.Achievement, error) {
	return []model.Achievement{{ID: "a1", Title: "ICPC"}}, nil
}

func TestRouter_RegistersAllAPIEndpoints(t *testing.T) {
	cfg := config.Config{AllowedOrigins: []string{"https://portfolio.app"}}
	h := handler.NewPortfolioHandler(&stubService{})
	r := New(cfg, h)

	tests := []struct {
		name string
		path string
	}{
		{name: "health", path: "/api/v1/health"},
		{name: "profile", path: "/api/v1/profile"},
		{name: "projects", path: "/api/v1/projects"},
		{name: "experience", path: "/api/v1/experience"},
		{name: "achievements", path: "/api/v1/achievements"},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			req := httptest.NewRequest(http.MethodGet, tt.path, nil)
			req.Header.Set("Origin", "https://portfolio.app")
			rec := httptest.NewRecorder()

			r.ServeHTTP(rec, req)

			if rec.Code != http.StatusOK {
				t.Fatalf("expected 200 for %s, got %d", tt.path, rec.Code)
			}

			if got := rec.Header().Get("Access-Control-Allow-Origin"); got != "https://portfolio.app" {
				t.Fatalf("unexpected CORS allow-origin header: %q", got)
			}

			var body map[string]any
			if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
				t.Fatalf("invalid JSON response: %v", err)
			}
			if body["status"] != "success" {
				t.Fatalf("expected success status, got %#v", body["status"])
			}
		})
	}
}

func TestRouter_HandlesPreflightWithCORS(t *testing.T) {
	cfg := config.Config{AllowedOrigins: []string{"*"}}
	h := handler.NewPortfolioHandler(&stubService{})
	r := New(cfg, h)

	req := httptest.NewRequest(http.MethodOptions, "/api/v1/profile", nil)
	req.Header.Set("Origin", "https://any.example")
	rec := httptest.NewRecorder()

	r.ServeHTTP(rec, req)

	if rec.Code != http.StatusNoContent {
		t.Fatalf("expected 204 for preflight, got %d", rec.Code)
	}
	if got := rec.Header().Get("Access-Control-Allow-Origin"); got != "*" {
		t.Fatalf("unexpected allow-origin for wildcard CORS: %q", got)
	}
}

func TestRouter_Returns404ForUnknownRoute(t *testing.T) {
	cfg := config.Config{AllowedOrigins: []string{"*"}}
	h := handler.NewPortfolioHandler(&stubService{})
	r := New(cfg, h)

	req := httptest.NewRequest(http.MethodGet, "/api/v1/unknown", nil)
	rec := httptest.NewRecorder()

	r.ServeHTTP(rec, req)

	if rec.Code != http.StatusNotFound {
		t.Fatalf("expected 404 for unknown route, got %d", rec.Code)
	}
}
