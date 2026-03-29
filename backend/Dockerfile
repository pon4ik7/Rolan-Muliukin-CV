FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY backend/go.mod backend/go.sum ./
RUN go mod download

COPY backend/ ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/server ./cmd/server

FROM alpine:3.20

WORKDIR /app

RUN addgroup -S app && adduser -S app -G app

COPY --from=builder /out/server /app/server
COPY backend/data/resume.json /app/data/resume.json

ENV PORT=8080
ENV DATA_FILE=/app/data/resume.json

EXPOSE 8080

USER app

CMD ["/app/server"]
