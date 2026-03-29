class ExperienceModel {
  ExperienceModel({
    required this.id,
    required this.title,
    required this.organization,
    required this.period,
    required this.description,
    required this.highlights,
    required this.techStack,
  });

  final String id;
  final String title;
  final String organization;
  final String period;
  final String description;
  final List<String> highlights;
  final List<String> techStack;

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      period: json['period'] as String? ?? '',
      description: json['description'] as String? ?? '',
      highlights: (json['highlights'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      techStack: (json['techStack'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
