package middleware

import (
	"log"
	"net/http"
	"time"
)

var suppressedLogPaths = map[string]struct{}{
	"/api/v1/health": {},
}

type responseRecorder struct {
	http.ResponseWriter
	statusCode int
}

func (r *responseRecorder) WriteHeader(code int) {
	r.statusCode = code
	r.ResponseWriter.WriteHeader(code)
}

func Logging(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if shouldSkipRequestLog(r) {
			next.ServeHTTP(w, r)
			return
		}

		start := time.Now()
		recorder := &responseRecorder{
			ResponseWriter: w,
			statusCode:     http.StatusOK,
		}

		next.ServeHTTP(recorder, r)

		log.Printf("%s %s %d %s", r.Method, r.URL.Path, recorder.statusCode, time.Since(start))
	})
}

func shouldSkipRequestLog(r *http.Request) bool {
	if r.Method == http.MethodOptions {
		return true
	}

	_, skip := suppressedLogPaths[r.URL.Path]
	return skip
}
