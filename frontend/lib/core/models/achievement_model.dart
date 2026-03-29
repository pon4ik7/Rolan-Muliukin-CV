class AchievementModel {
  AchievementModel({
    required this.id,
    required this.title,
    required this.category,
    required this.result,
    required this.description,
    required this.link,
  });

  final String id;
  final String title;
  final String category;
  final String result;
  final String description;
  final String link;

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      result: json['result'] as String? ?? '',
      description: json['description'] as String? ?? '',
      link: json['link'] as String? ?? '',
    );
  }
}
