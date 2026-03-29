package config

import (
	"os"
	"strconv"
	"strings"
	"time"
)

type Config struct {
	AppEnv          string
	Port            string
	DataFile        string
	AllowedOrigins  []string
	ReadTimeout     time.Duration
	WriteTimeout    time.Duration
	ShutdownTimeout time.Duration
}

func Load() Config {
	return Config{
		AppEnv:          getEnv("APP_ENV", "development"),
		Port:            getEnv("PORT", "8080"),
		DataFile:        getEnv("DATA_FILE", "data/resume.json"),
		AllowedOrigins:  splitCSV(getEnv("ALLOWED_ORIGINS", "*")),
		ReadTimeout:     getEnvAsDuration("READ_TIMEOUT_SEC", 10),
		WriteTimeout:    getEnvAsDuration("WRITE_TIMEOUT_SEC", 10),
		ShutdownTimeout: getEnvAsDuration("SHUTDOWN_TIMEOUT_SEC", 10),
	}
}

func getEnv(key, fallback string) string {
	val := strings.TrimSpace(os.Getenv(key))
	if val == "" {
		return fallback
	}
	return val
}

func splitCSV(value string) []string {
	parts := strings.Split(value, ",")
	out := make([]string, 0, len(parts))
	for _, part := range parts {
		trimmed := strings.TrimSpace(part)
		if trimmed != "" {
			out = append(out, trimmed)
		}
	}
	if len(out) == 0 {
		return []string{"*"}
	}
	return out
}

func getEnvAsDuration(key string, fallback int) time.Duration {
	raw := strings.TrimSpace(os.Getenv(key))
	if raw == "" {
		return time.Duration(fallback) * time.Second
	}

	seconds, err := strconv.Atoi(raw)
	if err != nil || seconds <= 0 {
		return time.Duration(fallback) * time.Second
	}
	return time.Duration(seconds) * time.Second
}
