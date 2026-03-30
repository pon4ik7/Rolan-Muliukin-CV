package model

type ResumeData struct {
	Profile      Profile       `json:"profile"`
	Projects     []Project     `json:"projects"`
	Experience   []Experience  `json:"experience"`
	Achievements []Achievement `json:"achievements"`
}

type Profile struct {
	Name                string              `json:"name"`
	NameRu              string              `json:"nameRu"`
	Role                string              `json:"role"`
	RoleRu              string              `json:"roleRu"`
	Headline            string              `json:"headline"`
	HeadlineRu          string              `json:"headlineRu"`
	Summary             string              `json:"summary"`
	SummaryRu           string              `json:"summaryRu"`
	AvailabilityBadge   string              `json:"availabilityBadge"`
	AvailabilityBadgeRu string              `json:"availabilityBadgeRu"`
	CareerFocus         string              `json:"careerFocus"`
	CareerFocusRu       string              `json:"careerFocusRu"`
	Contacts            Contacts            `json:"contacts"`
	Links               ExternalLinks       `json:"links"`
	PrimaryStack        []string            `json:"primaryStack"`
	TechStack           map[string][]string `json:"techStack"`
	TechStackRu         map[string][]string `json:"techStackRu"`
	Education           []Education         `json:"education"`
	AdditionalEducation []Education         `json:"additionalEducation"`
	SoftSkills          []string            `json:"softSkills"`
	SoftSkillsRu        []string            `json:"softSkillsRu"`
}

type Contacts struct {
	Phone      string `json:"phone"`
	Email      string `json:"email"`
	Telegram   string `json:"telegram"`
	Location   string `json:"location"`
	LocationRu string `json:"locationRu"`
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
	Institution   string `json:"institution"`
	InstitutionRu string `json:"institutionRu"`
	Program       string `json:"program"`
	ProgramRu     string `json:"programRu"`
	GPA           string `json:"gpa"`
	Period        string `json:"period"`
	PeriodRu      string `json:"periodRu"`
	Details       string `json:"details"`
	DetailsRu     string `json:"detailsRu"`
}

type Experience struct {
	ID             string   `json:"id"`
	Title          string   `json:"title"`
	TitleRu        string   `json:"titleRu"`
	Organization   string   `json:"organization"`
	OrganizationRu string   `json:"organizationRu"`
	Period         string   `json:"period"`
	PeriodRu       string   `json:"periodRu"`
	Description    string   `json:"description"`
	DescriptionRu  string   `json:"descriptionRu"`
	Highlights     []string `json:"highlights"`
	HighlightsRu   []string `json:"highlightsRu"`
	TechStack      []string `json:"techStack"`
}

type Project struct {
	ID            string   `json:"id"`
	Name          string   `json:"name"`
	NameRu        string   `json:"nameRu"`
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
	ID            string `json:"id"`
	Title         string `json:"title"`
	TitleRu       string `json:"titleRu"`
	Category      string `json:"category"`
	CategoryRu    string `json:"categoryRu"`
	Result        string `json:"result"`
	ResultRu      string `json:"resultRu"`
	Description   string `json:"description"`
	DescriptionRu string `json:"descriptionRu"`
	Link          string `json:"link"`
}
