package service

import (
	"context"
	"testing"

	"rolan-portfolio/backend/internal/model"
)

type mockPortfolioRepo struct {
	profile      model.Profile
	projects     []model.Project
	experience   []model.Experience
	achievements []model.Achievement
}

func (m *mockPortfolioRepo) GetProfile(_ context.Context) (model.Profile, error) {
	return m.profile, nil
}

func (m *mockPortfolioRepo) GetProjects(_ context.Context) ([]model.Project, error) {
	return m.projects, nil
}

func (m *mockPortfolioRepo) GetExperience(_ context.Context) ([]model.Experience, error) {
	return m.experience, nil
}

func (m *mockPortfolioRepo) GetAchievements(_ context.Context) ([]model.Achievement, error) {
	return m.achievements, nil
}

func TestPortfolioService_ReturnsRepositoryData(t *testing.T) {
	t.Parallel()

	repo := &mockPortfolioRepo{
		profile: model.Profile{Name: "Rolan Muliukin"},
		projects: []model.Project{
			{ID: "p1", Name: "Project One"},
		},
		experience: []model.Experience{
			{ID: "e1", Title: "Backend Developer"},
		},
		achievements: []model.Achievement{
			{ID: "a1", Title: "ICPC"},
		},
	}

	svc := NewPortfolioService(repo)
	ctx := context.Background()

	profile, err := svc.Profile(ctx)
	if err != nil {
		t.Fatalf("Profile returned error: %v", err)
	}
	if profile.Name != "Rolan Muliukin" {
		t.Fatalf("unexpected profile name: %s", profile.Name)
	}

	projects, err := svc.Projects(ctx)
	if err != nil {
		t.Fatalf("Projects returned error: %v", err)
	}
	if len(projects) != 1 || projects[0].ID != "p1" {
		t.Fatalf("unexpected projects payload: %+v", projects)
	}

	experience, err := svc.Experience(ctx)
	if err != nil {
		t.Fatalf("Experience returned error: %v", err)
	}
	if len(experience) != 1 || experience[0].ID != "e1" {
		t.Fatalf("unexpected experience payload: %+v", experience)
	}

	achievements, err := svc.Achievements(ctx)
	if err != nil {
		t.Fatalf("Achievements returned error: %v", err)
	}
	if len(achievements) != 1 || achievements[0].ID != "a1" {
		t.Fatalf("unexpected achievements payload: %+v", achievements)
	}
}
