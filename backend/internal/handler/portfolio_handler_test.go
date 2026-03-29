package handler

import (
	"context"
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"testing"

	"rolan-portfolio/backend/internal/model"
)

type mockPortfolioService struct {
	profileErr      error
	projectsErr     error
	experienceErr   error
	achievementsErr error
}

func (m *mockPortfolioService) Profile(_ context.Context) (model.Profile, error) {
	if m.profileErr != nil {
		return model.Profile{}, m.profileErr
	}
	return model.Profile{Name: "Rolan Muliukin"}, nil
}

func (m *mockPortfolioService) Projects(_ context.Context) ([]model.Project, error) {
	if m.projectsErr != nil {
		return nil, m.projectsErr
	}
	return []model.Project{{ID: "p1", Name: "Room Booking Service"}}, nil
}

func (m *mockPortfolioService) Experience(_ context.Context) ([]model.Experience, error) {
	if m.experienceErr != nil {
		return nil, m.experienceErr
	}
	return []model.Experience{{ID: "e1", Title: "Backend Developer"}}, nil
}

func (m *mockPortfolioService) Achievements(_ context.Context) ([]model.Achievement, error) {
	if m.achievementsErr != nil {
		return nil, m.achievementsErr
	}
	return []model.Achievement{{ID: "a1", Title: "ICPC"}}, nil
}

func TestGetHealth_ReturnsOkResponse(t *testing.T) {
	t.Parallel()

	h := NewPortfolioHandler(&mockPortfolioService{})
	req := httptest.NewRequest(http.MethodGet, "/api/v1/health", nil)
	rec := httptest.NewRecorder()

	h.GetHealth(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("expected 200, got %d", rec.Code)
	}

	var body map[string]any
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("failed to parse response: %v", err)
	}

	if body["status"] != "success" {
		t.Fatalf("expected success status, got %v", body["status"])
	}
}

func TestGetProfile_ReturnsSuccessPayload(t *testing.T) {
	t.Parallel()

	h := NewPortfolioHandler(&mockPortfolioService{})
	req := httptest.NewRequest(http.MethodGet, "/api/v1/profile", nil)
	rec := httptest.NewRecorder()

	h.GetProfile(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("expected 200, got %d", rec.Code)
	}

	var body struct {
		Status string `json:"status"`
		Data   struct {
			Name string `json:"name"`
		} `json:"data"`
	}
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("failed to parse response: %v", err)
	}

	if body.Status != "success" {
		t.Fatalf("expected success, got %s", body.Status)
	}
	if body.Data.Name != "Rolan Muliukin" {
		t.Fatalf("unexpected profile name: %s", body.Data.Name)
	}
}

func TestGetProfile_ReturnsInternalErrorOnServiceFailure(t *testing.T) {
	t.Parallel()

	h := NewPortfolioHandler(&mockPortfolioService{profileErr: errors.New("boom")})
	req := httptest.NewRequest(http.MethodGet, "/api/v1/profile", nil)
	rec := httptest.NewRecorder()

	h.GetProfile(rec, req)

	if rec.Code != http.StatusInternalServerError {
		t.Fatalf("expected 500, got %d", rec.Code)
	}

	var body struct {
		Status string `json:"status"`
		Error  struct {
			Message string `json:"message"`
		} `json:"error"`
	}
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("failed to parse response: %v", err)
	}

	if body.Status != "error" {
		t.Fatalf("expected error status, got %s", body.Status)
	}
	if body.Error.Message != "failed to load profile" {
		t.Fatalf("unexpected error message: %s", body.Error.Message)
	}
}

func TestListEndpoints_ReturnInternalErrorOnServiceFailure(t *testing.T) {
	t.Parallel()

	type testCase struct {
		name     string
		call     func(h *PortfolioHandler, w http.ResponseWriter, r *http.Request)
		path     string
		service  *mockPortfolioService
		expected string
	}

	tests := []testCase{
		{
			name:     "projects",
			call:     (*PortfolioHandler).GetProjects,
			path:     "/api/v1/projects",
			service:  &mockPortfolioService{projectsErr: errors.New("boom")},
			expected: "failed to load projects",
		},
		{
			name:     "experience",
			call:     (*PortfolioHandler).GetExperience,
			path:     "/api/v1/experience",
			service:  &mockPortfolioService{experienceErr: errors.New("boom")},
			expected: "failed to load experience",
		},
		{
			name:     "achievements",
			call:     (*PortfolioHandler).GetAchievements,
			path:     "/api/v1/achievements",
			service:  &mockPortfolioService{achievementsErr: errors.New("boom")},
			expected: "failed to load achievements",
		},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			h := NewPortfolioHandler(tt.service)
			req := httptest.NewRequest(http.MethodGet, tt.path, nil)
			rec := httptest.NewRecorder()

			tt.call(h, rec, req)

			if rec.Code != http.StatusInternalServerError {
				t.Fatalf("expected 500, got %d", rec.Code)
			}

			var body struct {
				Status string `json:"status"`
				Error  struct {
					Message string `json:"message"`
				} `json:"error"`
			}
			if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
				t.Fatalf("failed to parse response: %v", err)
			}

			if body.Status != "error" {
				t.Fatalf("expected error status, got %s", body.Status)
			}
			if body.Error.Message != tt.expected {
				t.Fatalf("unexpected error message: %s", body.Error.Message)
			}
		})
	}
}
