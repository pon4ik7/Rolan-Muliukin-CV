import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../state/portfolio_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/app_footer.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/error_state.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/projects_section.dart';
import '../widgets/soft_skills_section.dart';
import '../widgets/tech_stack_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PortfolioController _controller = PortfolioController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'about': GlobalKey(),
    'stack': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'education': GlobalKey(),
    'achievements': GlobalKey(),
    'contacts': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChange);
    _controller.load();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _scrollToSection(String key) async {
    final sectionKey = _sectionKeys[key];
    if (sectionKey?.currentContext == null) {
      return;
    }
    await Scrollable.ensureVisible(
      sectionKey!.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_controller.status) {
      case PortfolioStatus.loading:
        return const Scaffold(body: LoadingSkeleton());
      case PortfolioStatus.error:
        return Scaffold(
          body: ErrorState(
            message: _controller.errorMessage,
            onRetry: _controller.load,
          ),
        );
      case PortfolioStatus.ready:
        final bundle = _controller.bundle!;

        return Scaffold(
          body: Stack(
            children: [
              const _BackgroundGlow(),
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 74,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: SafeArea(
                      child: AppNavBar(
                        profile: bundle.profile,
                        onScrollToSection: _scrollToSection,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1220),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeroSection(
                                profile: bundle.profile,
                                onProjectsTap: () => _scrollToSection('projects'),
                                onContactTap: () => _scrollToSection('contacts'),
                              ),
                              const SizedBox(height: 42),
                              AnimatedReveal(
                                key: _sectionKeys['about'],
                                delayMs: 50,
                                child: AboutSection(profile: bundle.profile),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['stack'],
                                delayMs: 80,
                                child: TechStackSection(profile: bundle.profile),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['experience'],
                                delayMs: 110,
                                child: ExperienceSection(items: bundle.experience),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['projects'],
                                delayMs: 130,
                                child: ProjectsSection(items: bundle.projects),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['education'],
                                delayMs: 150,
                                child: EducationSection(profile: bundle.profile),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['achievements'],
                                delayMs: 170,
                                child: AchievementsSection(
                                  items: bundle.achievements,
                                ),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                child: SoftSkillsSection(profile: bundle.profile),
                              ),
                              const SizedBox(height: 44),
                              AnimatedReveal(
                                key: _sectionKeys['contacts'],
                                delayMs: 190,
                                child: ContactSection(profile: bundle.profile),
                              ),
                              AppFooter(name: bundle.profile.name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF060B18), Color(0xFF070D1B), Color(0xFF050A16)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            left: -120,
            child: _GlowCircle(
              size: 370,
              colors: const [Color(0x553E8BFF), Color(0x113E8BFF)],
            ),
          ),
          Positioned(
            top: 260,
            right: -90,
            child: _GlowCircle(
              size: 280,
              colors: const [Color(0x4435D5FF), Color(0x1135D5FF)],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }
}
