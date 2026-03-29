package repository

import (
	"context"

	"rolan-portfolio/backend/internal/model"
)

type PortfolioRepository interface {
	GetProfile(ctx context.Context) (model.Profile, error)
	GetProjects(ctx context.Context) ([]model.Project, error)
	GetExperience(ctx context.Context) ([]model.Experience, error)
	GetAchievements(ctx context.Context) ([]model.Achievement, error)
}
