package handler

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"rolan-portfolio/backend/internal/model"
)

type successServiceStub struct{}

func (s *successServiceStub) Profile(context.Context) (model.Profile, error) {
	return model.Profile{Name: "Rolan Muliukin"}, nil
}

func (s *successServiceStub) Projects(context.Context) ([]model.Project, error) {
	return []model.Project{{ID: "p1", Name: "Room Booking Service"}}, nil
}

func (s *successServiceStub) Experience(context.Context) ([]model.Experience, error) {
	return []model.Experience{{ID: "e1", Title: "Backend Developer"}}, nil
}

func (s *successServiceStub) Achievements(context.Context) ([]model.Achievement, error) {
	return []model.Achievement{{ID: "a1", Title: "ICPC"}}, nil
}

func TestListEndpoints_ReturnSuccessPayloads(t *testing.T) {
	t.Parallel()

	h := NewPortfolioHandler(&successServiceStub{})

	tests := []struct {
		name    string
		path    string
		call    func(*PortfolioHandler, http.ResponseWriter, *http.Request)
		extract func(map[string]any) any
	}{
		{
			name: "projects",
			path: "/api/v1/projects",
			call: (*PortfolioHandler).GetProjects,
			extract: func(body map[string]any) any {
				data, ok := body["data"].([]any)
				if !ok || len(data) == 0 {
					return nil
				}
				item, _ := data[0].(map[string]any)
				return item["id"]
			},
		},
		{
			name: "experience",
			path: "/api/v1/experience",
			call: (*PortfolioHandler).GetExperience,
			extract: func(body map[string]any) any {
				data, ok := body["data"].([]any)
				if !ok || len(data) == 0 {
					return nil
				}
				item, _ := data[0].(map[string]any)
				return item["id"]
			},
		},
		{
			name: "achievements",
			path: "/api/v1/achievements",
			call: (*PortfolioHandler).GetAchievements,
			extract: func(body map[string]any) any {
				data, ok := body["data"].([]any)
				if !ok || len(data) == 0 {
					return nil
				}
				item, _ := data[0].(map[string]any)
				return item["id"]
			},
		},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			rec := httptest.NewRecorder()
			req := httptest.NewRequest(http.MethodGet, tt.path, nil)

			tt.call(h, rec, req)

			if rec.Code != http.StatusOK {
				t.Fatalf("expected 200, got %d", rec.Code)
			}

			var body map[string]any
			if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
				t.Fatalf("invalid JSON response: %v", err)
			}
			if body["status"] != "success" {
				t.Fatalf("expected success status, got %v", body["status"])
			}
			if got := tt.extract(body); got == nil {
				t.Fatalf("expected non-empty data payload for %s", tt.name)
			}
		})
	}
}
