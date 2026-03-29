import 'achievement_model.dart';
import 'experience_model.dart';
import 'profile_model.dart';
import 'project_model.dart';

class PortfolioBundle {
  PortfolioBundle({
    required this.profile,
    required this.projects,
    required this.experience,
    required this.achievements,
  });

  final ProfileModel profile;
  final List<ProjectModel> projects;
  final List<ExperienceModel> experience;
  final List<AchievementModel> achievements;
}
