import 'package:flutter/material.dart';

import '../../../../core/models/project_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import 'glass_card.dart';
import 'section_title.dart';
import 'skill_chip.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.items, super.key});

  final List<ProjectModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Projects',
          subtitle: 'Backend Systems I Built',
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map(
                (item) => SizedBox(
                  width: 410,
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.titleLarge
                                        ?.copyWith(fontSize: 22),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.role,
                                    style: Theme.of(context).textTheme.bodyMedium
                                        ?.copyWith(color: AppPalette.secondary),
                                  ),
                                ],
                              ),
                            ),
                            if (item.repository.isNotEmpty)
                              IconButton(
                                onPressed: () => launchExternalLink(item.repository),
                                tooltip: 'Open repository',
                                icon: const Icon(Icons.open_in_new),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(item.description),
                        const SizedBox(height: 12),
                        ...item.highlights.map(
                          (point) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, right: 8),
                                  child: Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: AppPalette.primary,
                                  ),
                                ),
                                Expanded(child: Text(point)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.techStack
                              .map((skill) => SkillChip(label: skill))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
