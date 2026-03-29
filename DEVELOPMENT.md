# DEVELOPMENT WORKFLOW

This project was developed with branch-per-feature workflow:
- main -> stable
- dev -> integration branch
- feature/backend-init
- feature/frontend-ui
- feature/docker-setup
- feature/testing
- feature/docs

## Git Log (graph style)

```text
* b3c4b46 (HEAD -> main) ci: add github actions pipeline for backend tests
* d978ec0 test: add handler endpoint unit tests
* ce9d838 feat: support bilingual CV download buttons (EN/RU)
* 3ed2c37 (origin/main) chore: add makefile shortcuts for local workflow
*   bb34b93 merge: release portfolio project to main
|\  
| * ca9ede7 (dev) docs: update development log after documentation merge
| *   1a18a6f merge: integrate project documentation
| |\  
| | * 0168c6e (feature/docs) docs: refresh git log snapshot in development notes
| | * 6f089fb docs: add setup guide and development workflow log
| |/  
| *   6673330 merge: integrate backend tests
| |\  
| | * 90bef99 (feature/testing) test: add unit tests for repository and service layers
| |/  
| *   1f0051a merge: integrate docker and nginx infrastructure
| |\  
| | * 8a270bf (feature/docker-setup) chore: setup docker compose and nginx reverse proxy
| | * 3ddefc8 fix: use compatible card theme for flutter web build
| |/  
| *   055858c (origin/feature/docker-setup) merge: integrate frontend portfolio ui
| |\  
| | * 773b827 (feature/frontend-ui) feat: implement responsive portfolio sections and interactions
| | * 7b99464 feat: add flutter frontend foundation and api data layer
| |/  
| * 61c2f8a merge: integrate backend initialization
|/| 
| * b36113d (feature/backend-init) feat: add resume-driven portfolio seed data
| * d2860ce feat: initialize backend API architecture
|/  
* ba3b974 chore: initialize repository with gitignore
```
