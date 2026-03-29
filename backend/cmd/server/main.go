package main

import (
	"context"
	"errors"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"rolan-portfolio/backend/internal/config"
	"rolan-portfolio/backend/internal/handler"
	"rolan-portfolio/backend/internal/repository"
	"rolan-portfolio/backend/internal/router"
	"rolan-portfolio/backend/internal/service"
)

func main() {
	cfg := config.Load()

	repo, err := repository.NewStaticRepository(cfg.DataFile)
	if err != nil {
		log.Fatalf("failed to initialize repository: %v", err)
	}

	svc := service.NewPortfolioService(repo)
	h := handler.NewPortfolioHandler(svc)
	r := router.New(cfg, h)

	server := &http.Server{
		Addr:         ":" + cfg.Port,
		Handler:      r,
		ReadTimeout:  cfg.ReadTimeout,
		WriteTimeout: cfg.WriteTimeout,
	}

	go func() {
		log.Printf("portfolio API is running on port %s", cfg.Port)
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatalf("failed to start server: %v", err)
		}
	}()

	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh

	ctx, cancel := context.WithTimeout(context.Background(), cfg.ShutdownTimeout)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		log.Fatalf("failed to shutdown server: %v", err)
	}

	log.Println("server stopped gracefully")
}
