package config

import (
	"reflect"
	"testing"
	"time"
)

func TestLoad_UsesDefaultsWhenEnvMissing(t *testing.T) {
	t.Setenv("APP_ENV", "")
	t.Setenv("PORT", "")
	t.Setenv("DATA_FILE", "")
	t.Setenv("ALLOWED_ORIGINS", "")
	t.Setenv("READ_TIMEOUT_SEC", "")
	t.Setenv("WRITE_TIMEOUT_SEC", "")
	t.Setenv("SHUTDOWN_TIMEOUT_SEC", "")

	cfg := Load()

	if cfg.AppEnv != "development" {
		t.Fatalf("expected default app env, got %q", cfg.AppEnv)
	}
	if cfg.Port != "8080" {
		t.Fatalf("expected default port, got %q", cfg.Port)
	}
	if cfg.DataFile != "data/resume.json" {
		t.Fatalf("expected default data file, got %q", cfg.DataFile)
	}
	if !reflect.DeepEqual(cfg.AllowedOrigins, []string{"*"}) {
		t.Fatalf("expected wildcard origins, got %#v", cfg.AllowedOrigins)
	}
	if cfg.ReadTimeout != 10*time.Second {
		t.Fatalf("expected default read timeout, got %s", cfg.ReadTimeout)
	}
	if cfg.WriteTimeout != 10*time.Second {
		t.Fatalf("expected default write timeout, got %s", cfg.WriteTimeout)
	}
	if cfg.ShutdownTimeout != 10*time.Second {
		t.Fatalf("expected default shutdown timeout, got %s", cfg.ShutdownTimeout)
	}
}

func TestLoad_ParsesEnvironmentValues(t *testing.T) {
	t.Setenv("APP_ENV", "production")
	t.Setenv("PORT", "9000")
	t.Setenv("DATA_FILE", "/tmp/resume.json")
	t.Setenv("ALLOWED_ORIGINS", "https://one.app, https://two.app")
	t.Setenv("READ_TIMEOUT_SEC", "30")
	t.Setenv("WRITE_TIMEOUT_SEC", "31")
	t.Setenv("SHUTDOWN_TIMEOUT_SEC", "32")

	cfg := Load()

	if cfg.AppEnv != "production" {
		t.Fatalf("unexpected app env: %q", cfg.AppEnv)
	}
	if cfg.Port != "9000" {
		t.Fatalf("unexpected port: %q", cfg.Port)
	}
	if cfg.DataFile != "/tmp/resume.json" {
		t.Fatalf("unexpected data file: %q", cfg.DataFile)
	}
	expectedOrigins := []string{"https://one.app", "https://two.app"}
	if !reflect.DeepEqual(cfg.AllowedOrigins, expectedOrigins) {
		t.Fatalf("unexpected origins: %#v", cfg.AllowedOrigins)
	}
	if cfg.ReadTimeout != 30*time.Second {
		t.Fatalf("unexpected read timeout: %s", cfg.ReadTimeout)
	}
	if cfg.WriteTimeout != 31*time.Second {
		t.Fatalf("unexpected write timeout: %s", cfg.WriteTimeout)
	}
	if cfg.ShutdownTimeout != 32*time.Second {
		t.Fatalf("unexpected shutdown timeout: %s", cfg.ShutdownTimeout)
	}
}

func TestSplitCSV_DropsEmptyPartsAndFallsBack(t *testing.T) {
	tests := []struct {
		name  string
		input string
		want  []string
	}{
		{
			name:  "normal list",
			input: "a,b,c",
			want:  []string{"a", "b", "c"},
		},
		{
			name:  "list with spaces and empty chunks",
			input: " a, , b ,, c ",
			want:  []string{"a", "b", "c"},
		},
		{
			name:  "fully empty",
			input: " , , ",
			want:  []string{"*"},
		},
	}

	for _, tt := range tests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			got := splitCSV(tt.input)
			if !reflect.DeepEqual(got, tt.want) {
				t.Fatalf("unexpected split result: got=%#v want=%#v", got, tt.want)
			}
		})
	}
}

func TestGetEnvAsDuration_UsesFallbackOnInvalidInput(t *testing.T) {
	t.Setenv("TIMEOUT", "invalid")
	if got := getEnvAsDuration("TIMEOUT", 12); got != 12*time.Second {
		t.Fatalf("expected fallback for invalid value, got %s", got)
	}

	t.Setenv("TIMEOUT", "0")
	if got := getEnvAsDuration("TIMEOUT", 12); got != 12*time.Second {
		t.Fatalf("expected fallback for non-positive value, got %s", got)
	}

	t.Setenv("TIMEOUT", "8")
	if got := getEnvAsDuration("TIMEOUT", 12); got != 8*time.Second {
		t.Fatalf("expected parsed timeout, got %s", got)
	}
}
