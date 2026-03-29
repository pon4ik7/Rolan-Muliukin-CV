package repository

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"sync"

	"rolan-portfolio/backend/internal/model"
)

type StaticRepository struct {
	mu   sync.RWMutex
	data model.ResumeData
}

func NewStaticRepository(filePath string) (*StaticRepository, error) {
	raw, err := os.ReadFile(filePath)
	if err != nil {
		return nil, fmt.Errorf("read data file: %w", err)
	}

	var payload model.ResumeData
	if err := json.Unmarshal(raw, &payload); err != nil {
		return nil, fmt.Errorf("parse data file: %w", err)
	}

	return &StaticRepository{data: payload}, nil
}

func (r *StaticRepository) GetProfile(_ context.Context) (model.Profile, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return r.data.Profile, nil
}

func (r *StaticRepository) GetProjects(_ context.Context) ([]model.Project, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return append([]model.Project(nil), r.data.Projects...), nil
}

func (r *StaticRepository) GetExperience(_ context.Context) ([]model.Experience, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return append([]model.Experience(nil), r.data.Experience...), nil
}

func (r *StaticRepository) GetAchievements(_ context.Context) ([]model.Achievement, error) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return append([]model.Achievement(nil), r.data.Achievements...), nil
}
