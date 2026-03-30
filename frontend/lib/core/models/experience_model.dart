class ExperienceModel {
  ExperienceModel({
    required this.id,
    required this.title,
    required this.titleRu,
    required this.organization,
    required this.organizationRu,
    required this.period,
    required this.periodRu,
    required this.description,
    required this.descriptionRu,
    required this.highlights,
    required this.highlightsRu,
    required this.techStack,
  });

  final String id;
  final String title;
  final String titleRu;
  final String organization;
  final String organizationRu;
  final String period;
  final String periodRu;
  final String description;
  final String descriptionRu;
  final List<String> highlights;
  final List<String> highlightsRu;
  final List<String> techStack;

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleRu: json['titleRu'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      organizationRu: json['organizationRu'] as String? ?? '',
      period: json['period'] as String? ?? '',
      periodRu: json['periodRu'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionRu: json['descriptionRu'] as String? ?? '',
      highlights: (json['highlights'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      highlightsRu: (json['highlightsRu'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      techStack: (json['techStack'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
