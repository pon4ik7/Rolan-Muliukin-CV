class ProjectModel {
  ProjectModel({
    required this.id,
    required this.name,
    required this.role,
    required this.roleRu,
    required this.description,
    required this.descriptionRu,
    required this.highlights,
    required this.highlightsRu,
    required this.techStack,
    required this.repository,
  });

  final String id;
  final String name;
  final String role;
  final String roleRu;
  final String description;
  final String descriptionRu;
  final List<String> highlights;
  final List<String> highlightsRu;
  final List<String> techStack;
  final String repository;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      roleRu: json['roleRu'] as String? ?? '',
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
      repository: json['repository'] as String? ?? '',
    );
  }
}
