package service

import (
	"context"

	"rolan-portfolio/backend/internal/model"
	"rolan-portfolio/backend/internal/repository"
)

type PortfolioService interface {
	Profile(ctx context.Context) (model.Profile, error)
	Projects(ctx context.Context) ([]model.Project, error)
	Experience(ctx context.Context) ([]model.Experience, error)
	Achievements(ctx context.Context) ([]model.Achievement, error)
}

type portfolioService struct {
	repo repository.PortfolioRepository
}

func NewPortfolioService(repo repository.PortfolioRepository) PortfolioService {
	return &portfolioService{repo: repo}
}

func (s *portfolioService) Profile(ctx context.Context) (model.Profile, error) {
	return s.repo.GetProfile(ctx)
}

func (s *portfolioService) Projects(ctx context.Context) ([]model.Project, error) {
	return s.repo.GetProjects(ctx)
}

func (s *portfolioService) Experience(ctx context.Context) ([]model.Experience, error) {
	return s.repo.GetExperience(ctx)
}

func (s *portfolioService) Achievements(ctx context.Context) ([]model.Achievement, error) {
	return s.repo.GetAchievements(ctx)
}
