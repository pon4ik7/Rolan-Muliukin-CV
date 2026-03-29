package middleware

import (
	"net/http"
	"slices"
)

func CORS(allowedOrigins []string) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			origin := r.Header.Get("Origin")
			allowedOrigin := resolveOrigin(origin, allowedOrigins)

			if allowedOrigin != "" {
				w.Header().Set("Access-Control-Allow-Origin", allowedOrigin)
				w.Header().Set("Vary", "Origin")
			}
			w.Header().Set("Access-Control-Allow-Methods", "GET, OPTIONS")
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

			if r.Method == http.MethodOptions {
				w.WriteHeader(http.StatusNoContent)
				return
			}

			next.ServeHTTP(w, r)
		})
	}
}

func resolveOrigin(origin string, allowedOrigins []string) string {
	if len(allowedOrigins) == 0 {
		return ""
	}
	if slices.Contains(allowedOrigins, "*") {
		return "*"
	}
	if origin == "" {
		return ""
	}
	if slices.Contains(allowedOrigins, origin) {
		return origin
	}
	return ""
}
