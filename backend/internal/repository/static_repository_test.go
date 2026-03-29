package repository

import (
	"context"
	"os"
	"path/filepath"
	"testing"
)

func TestStaticRepository_LoadsDataFromJSON(t *testing.T) {
	t.Parallel()

	data := `{
		"profile":{"name":"Rolan","role":"Backend Developer","headline":"h","summary":"s","availabilityBadge":"a","careerFocus":"c","contacts":{"phone":"1","email":"2","telegram":"3","location":"4"},"links":{"github":"","leetcode":"","codeforces":"","telegram":"","university":"","cvDownload":"","contactMail":""},"primaryStack":["Go"],"techStack":{"Languages":["Go"]},"education":[],"additionalEducation":[],"softSkills":["Teamwork"]},
		"projects":[{"id":"p1","name":"Project","role":"Backend","description":"desc","highlights":["h1"],"techStack":["Go"],"repository":"repo"}],
		"experience":[{"id":"e1","title":"Backend Developer","organization":"Team","period":"2025","description":"desc","highlights":["h1"],"techStack":["Go"]}],
		"achievements":[{"id":"a1","title":"ICPC","category":"Programming","result":"III","description":"desc","link":"link"}]
	}`

	filePath := filepath.Join(t.TempDir(), "resume.json")
	if err := os.WriteFile(filePath, []byte(data), 0o600); err != nil {
		t.Fatalf("failed to write fixture: %v", err)
	}

	repo, err := NewStaticRepository(filePath)
	if err != nil {
		t.Fatalf("NewStaticRepository returned error: %v", err)
	}

	ctx := context.Background()

	profile, err := repo.GetProfile(ctx)
	if err != nil {
		t.Fatalf("GetProfile returned error: %v", err)
	}
	if profile.Name != "Rolan" {
		t.Fatalf("unexpected profile name: %s", profile.Name)
	}

	projects, err := repo.GetProjects(ctx)
	if err != nil || len(projects) != 1 {
		t.Fatalf("unexpected projects result: err=%v len=%d", err, len(projects))
	}

	experience, err := repo.GetExperience(ctx)
	if err != nil || len(experience) != 1 {
		t.Fatalf("unexpected experience result: err=%v len=%d", err, len(experience))
	}

	achievements, err := repo.GetAchievements(ctx)
	if err != nil || len(achievements) != 1 {
		t.Fatalf("unexpected achievements result: err=%v len=%d", err, len(achievements))
	}
}
