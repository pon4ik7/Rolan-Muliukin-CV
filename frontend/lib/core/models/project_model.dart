class ProjectModel {
  ProjectModel({
    required this.id,
    required this.name,
    required this.role,
    required this.description,
    required this.highlights,
    required this.techStack,
    required this.repository,
  });

  final String id;
  final String name;
  final String role;
  final String description;
  final List<String> highlights;
  final List<String> techStack;
  final String repository;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      description: json['description'] as String? ?? '',
      highlights: (json['highlights'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      techStack: (json['techStack'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      repository: json['repository'] as String? ?? '',
    );
  }
}
