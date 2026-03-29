package handler

import (
	"net/http"
	"time"

	"rolan-portfolio/backend/internal/service"
)

type PortfolioHandler struct {
	service service.PortfolioService
}

func NewPortfolioHandler(svc service.PortfolioService) *PortfolioHandler {
	return &PortfolioHandler{service: svc}
}

func (h *PortfolioHandler) GetHealth(w http.ResponseWriter, _ *http.Request) {
	writeSuccess(w, http.StatusOK, map[string]any{
		"service":   "rolan-portfolio-api",
		"status":    "ok",
		"timestamp": time.Now().UTC().Format(time.RFC3339),
	})
}

func (h *PortfolioHandler) GetProfile(w http.ResponseWriter, r *http.Request) {
	profile, err := h.service.Profile(r.Context())
	if err != nil {
		writeError(w, http.StatusInternalServerError, "failed to load profile")
		return
	}
	writeSuccess(w, http.StatusOK, profile)
}

func (h *PortfolioHandler) GetProjects(w http.ResponseWriter, r *http.Request) {
	projects, err := h.service.Projects(r.Context())
	if err != nil {
		writeError(w, http.StatusInternalServerError, "failed to load projects")
		return
	}
	writeSuccess(w, http.StatusOK, projects)
}

func (h *PortfolioHandler) GetExperience(w http.ResponseWriter, r *http.Request) {
	experience, err := h.service.Experience(r.Context())
	if err != nil {
		writeError(w, http.StatusInternalServerError, "failed to load experience")
		return
	}
	writeSuccess(w, http.StatusOK, experience)
}

func (h *PortfolioHandler) GetAchievements(w http.ResponseWriter, r *http.Request) {
	achievements, err := h.service.Achievements(r.Context())
	if err != nil {
		writeError(w, http.StatusInternalServerError, "failed to load achievements")
		return
	}
	writeSuccess(w, http.StatusOK, achievements)
}
