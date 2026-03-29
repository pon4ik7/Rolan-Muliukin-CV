package model

type ResumeData struct {
	Profile      Profile       `json:"profile"`
	Projects     []Project     `json:"projects"`
	Experience   []Experience  `json:"experience"`
	Achievements []Achievement `json:"achievements"`
}

type Profile struct {
	Name                string              `json:"name"`
	Role                string              `json:"role"`
	Headline            string              `json:"headline"`
	Summary             string              `json:"summary"`
	SummaryRu           string              `json:"summaryRu"`
	AvailabilityBadge   string              `json:"availabilityBadge"`
	CareerFocus         string              `json:"careerFocus"`
	CareerFocusRu       string              `json:"careerFocusRu"`
	Contacts            Contacts            `json:"contacts"`
	Links               ExternalLinks       `json:"links"`
	PrimaryStack        []string            `json:"primaryStack"`
	TechStack           map[string][]string `json:"techStack"`
	Education           []Education         `json:"education"`
	AdditionalEducation []Education         `json:"additionalEducation"`
	SoftSkills          []string            `json:"softSkills"`
}

type Contacts struct {
	Phone    string `json:"phone"`
	Email    string `json:"email"`
	Telegram string `json:"telegram"`
	Location string `json:"location"`
}

type ExternalLinks struct {
	GitHub       string `json:"github"`
	LeetCode     string `json:"leetcode"`
	Codeforces   string `json:"codeforces"`
	Telegram     string `json:"telegram"`
	University   string `json:"university"`
	CVDownload   string `json:"cvDownload"`
	CVDownloadEn string `json:"cvDownloadEn"`
	CVDownloadRu string `json:"cvDownloadRu"`
	ContactMail  string `json:"contactMail"`
}

type Education struct {
	Institution string `json:"institution"`
	Program     string `json:"program"`
	GPA         string `json:"gpa"`
	Period      string `json:"period"`
	Details     string `json:"details"`
}

type Experience struct {
	ID           string   `json:"id"`
	Title        string   `json:"title"`
	Organization string   `json:"organization"`
	Period       string   `json:"period"`
	Description  string   `json:"description"`
	Highlights   []string `json:"highlights"`
	TechStack    []string `json:"techStack"`
}

type Project struct {
	ID            string   `json:"id"`
	Name          string   `json:"name"`
	Role          string   `json:"role"`
	RoleRu        string   `json:"roleRu"`
	Description   string   `json:"description"`
	DescriptionRu string   `json:"descriptionRu"`
	Highlights    []string `json:"highlights"`
	HighlightsRu  []string `json:"highlightsRu"`
	TechStack     []string `json:"techStack"`
	Repository    string   `json:"repository"`
}

type Achievement struct {
	ID          string `json:"id"`
	Title       string `json:"title"`
	Category    string `json:"category"`
	Result      string `json:"result"`
	Description string `json:"description"`
	Link        string `json:"link"`
}
