# Rolan Muliukin Portfolio Website

Production-like personal portfolio and resume website for **Rolan Muliukin (Backend Developer)** built with:
- **Frontend:** Flutter Web
- **Backend:** Go (chi + net/http)
- **Infra:** Docker, Docker Compose, Nginx reverse proxy

The project is designed to look and feel like a polished junior/intern backend portfolio while keeping code maintainable for further growth (contact form, admin panel, analytics, database migration).

## Why Single-Page
This project uses a **single-page structure** with smooth in-page navigation because:
- recruiters can scan all key sections quickly;
- UX is fast and distraction-free;
- sections still stay modular in code and can be split into routes later.

## Implemented Features
- Modern dark UI with backend/engineering visual style
- Sticky navigation and smooth section scrolling
- Hero, About, Tech Stack, Experience, Projects, Education, Achievements, Soft Skills, Contact
- Card-based layout, chips/badges, timeline-like experience cards
- Loading skeleton and error state for API requests
- Copy-email action and direct CTA links
- SEO/Open Graph placeholders in Flutter web `index.html`
- REST API with clean architecture and JSON responses
- Config-driven backend content (no hardcoded resume content in Flutter widgets)
- End-to-end Docker stack with reverse proxy

## Resume Data Source
All content is based on `Rolan Muliukin CV.pdf` facts and translated/adapted into professional English text.

For links/placeholders management in one place, edit:
- `backend/data/resume.json` -> `profile.links` block (GitHub, LeetCode, Codeforces, Telegram, CV)

`cvDownload` currently uses placeholder:
- `TODO_ADD_PUBLIC_CV_URL`

## Project Structure
```text
.
├── backend
│   ├── cmd/server
│   ├── data/resume.json
│   ├── internal
│   │   ├── config
│   │   ├── handler
│   │   ├── middleware
│   │   ├── model
│   │   ├── repository
│   │   ├── router
│   │   └── service
│   └── Dockerfile
├── frontend
│   ├── lib
│   │   ├── core
│   │   └── features/portfolio
│   ├── web
│   ├── Dockerfile
│   └── nginx.conf
├── nginx
│   └── nginx.conf
├── docker-compose.yml
├── .env.example
├── README.md
└── DEVELOPMENT.md
```

## Backend API
Base path: `/api/v1`

- `GET /api/v1/health`
- `GET /api/v1/profile`
- `GET /api/v1/projects`
- `GET /api/v1/experience`
- `GET /api/v1/achievements`

Response format:
```json
{
  "status": "success",
  "data": {}
}
```

## Environment Variables
Use `.env.example` as template.

Key variables:
- `APP_PORT` - exposed local port for Nginx gateway (example: `8088`)
- `BACKEND_PORT` - backend container internal port
- `ALLOWED_ORIGINS` - CORS origins list (`*` by default)
- `FRONTEND_API_BASE_URL` - API base path embedded in Flutter build (`/api/v1`)

## Run Locally with Docker
1. Create env file:
   ```bash
   cp .env.example .env
   ```
2. Build and start:
   ```bash
   docker compose up --build
   ```
3. Open:
   - `http://localhost:8088` (if `APP_PORT=8088`)

Stop containers:
```bash
docker compose down
```

### Alternative via Makefile
```bash
make up-build
make ps
make logs
make down
```

## Validation Commands
Backend tests:
```bash
cd backend
go test ./...
```

Docker checks:
```bash
docker compose config
docker compose build backend
docker compose build frontend
```

## How to Update Content
Primary content source:
- `backend/data/resume.json`

Typical updates:
- profile summary/headline/career focus
- project cards and stacks
- achievements and certificate links
- contacts and social links

Frontend consumes backend API dynamically, so no UI hardcode changes are needed for text updates.

## Deployment Notes
Current setup is deployment-ready with minor production hardening:
- set real domain and HTTPS termination (Nginx + certbot or cloud LB)
- move resume data to PostgreSQL
- add contact form endpoint and anti-spam checks
- add analytics and server-side request metrics
- add CI/CD pipeline (lint, tests, image build, deploy)

## Next Improvements
1. Add light theme toggle and persisted user preference.
2. Add admin/content panel (or CMS) for editing resume JSON via UI.
3. Add contact form with backend validation and email queue.
4. Add caching headers and CDN strategy for static assets.
5. Add integration tests for API response contracts.
