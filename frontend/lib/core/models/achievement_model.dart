class AchievementModel {
  AchievementModel({
    required this.id,
    required this.title,
    required this.titleRu,
    required this.category,
    required this.categoryRu,
    required this.result,
    required this.resultRu,
    required this.description,
    required this.descriptionRu,
    required this.link,
  });

  final String id;
  final String title;
  final String titleRu;
  final String category;
  final String categoryRu;
  final String result;
  final String resultRu;
  final String description;
  final String descriptionRu;
  final String link;

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleRu: json['titleRu'] as String? ?? '',
      category: json['category'] as String? ?? '',
      categoryRu: json['categoryRu'] as String? ?? '',
      result: json['result'] as String? ?? '',
      resultRu: json['resultRu'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionRu: json['descriptionRu'] as String? ?? '',
      link: json['link'] as String? ?? '',
    );
  }
}
