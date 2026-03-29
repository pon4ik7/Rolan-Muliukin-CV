package router

import (
	"net/http"

	"github.com/go-chi/chi/v5"

	"rolan-portfolio/backend/internal/config"
	"rolan-portfolio/backend/internal/handler"
	"rolan-portfolio/backend/internal/middleware"
)

func New(cfg config.Config, h *handler.PortfolioHandler) http.Handler {
	r := chi.NewRouter()

	r.Use(middleware.Recovery)
	r.Use(middleware.Logging)
	r.Use(middleware.CORS(cfg.AllowedOrigins))

	r.Route("/api/v1", func(api chi.Router) {
		api.Get("/health", h.GetHealth)
		api.Get("/profile", h.GetProfile)
		api.Get("/projects", h.GetProjects)
		api.Get("/experience", h.GetExperience)
		api.Get("/achievements", h.GetAchievements)
	})

	return r
}
