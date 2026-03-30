package service

import (
	"context"
	"errors"
	"testing"

	"rolan-portfolio/backend/internal/model"
)

type errorRepo struct {
	profileErr      error
	projectsErr     error
	experienceErr   error
	achievementsErr error
}

func (r *errorRepo) GetProfile(context.Context) (model.Profile, error) {
	return model.Profile{}, r.profileErr
}

func (r *errorRepo) GetProjects(context.Context) ([]model.Project, error) {
	return nil, r.projectsErr
}

func (r *errorRepo) GetExperience(context.Context) ([]model.Experience, error) {
	return nil, r.experienceErr
}

func (r *errorRepo) GetAchievements(context.Context) ([]model.Achievement, error) {
	return nil, r.achievementsErr
}

func TestPortfolioService_PropagatesRepositoryErrors(t *testing.T) {
	t.Parallel()

	profileErr := errors.New("profile fail")
	projectsErr := errors.New("projects fail")
	experienceErr := errors.New("experience fail")
	achievementsErr := errors.New("achievements fail")

	svc := NewPortfolioService(&errorRepo{
		profileErr:      profileErr,
		projectsErr:     projectsErr,
		experienceErr:   experienceErr,
		achievementsErr: achievementsErr,
	})
	ctx := context.Background()

	if _, err := svc.Profile(ctx); !errors.Is(err, profileErr) {
		t.Fatalf("expected profile error to propagate, got %v", err)
	}
	if _, err := svc.Projects(ctx); !errors.Is(err, projectsErr) {
		t.Fatalf("expected projects error to propagate, got %v", err)
	}
	if _, err := svc.Experience(ctx); !errors.Is(err, experienceErr) {
		t.Fatalf("expected experience error to propagate, got %v", err)
	}
	if _, err := svc.Achievements(ctx); !errors.Is(err, achievementsErr) {
		t.Fatalf("expected achievements error to propagate, got %v", err)
	}
}
