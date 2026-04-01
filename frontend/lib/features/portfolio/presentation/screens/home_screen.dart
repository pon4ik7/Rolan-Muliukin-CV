import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/link_utils.dart';
import '../state/portfolio_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/animated_reveal.dart';
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
  AppLanguage _selectedLanguage = AppLanguage.ru;
  bool _languageInitialized = false;
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
    if (_controller.status == PortfolioStatus.ready && !_languageInitialized) {
      final links = _controller.bundle?.profile.links;
      if (links != null) {
        _selectedLanguage = links.hasCvRu ? AppLanguage.ru : AppLanguage.en;
      }
      _languageInitialized = true;
    }
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

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage.toggled;
    });
  }

  _CvDownloadSelection _resolveCvSelection(LinksModel links) {
    if (_selectedLanguage == AppLanguage.ru && links.hasCvRu) {
      return _CvDownloadSelection(
        url: links.cvDownloadRu,
        language: AppLanguage.ru,
      );
    }
    if (_selectedLanguage == AppLanguage.en && links.hasCvEn) {
      return _CvDownloadSelection(
        url: links.cvDownloadEn,
        language: AppLanguage.en,
      );
    }
    if (links.hasCvRu) {
      return _CvDownloadSelection(
        url: links.cvDownloadRu,
        language: AppLanguage.ru,
      );
    }
    if (links.hasCvEn) {
      return _CvDownloadSelection(
        url: links.cvDownloadEn,
        language: AppLanguage.en,
      );
    }
    final hasLegacyCv =
        links.cvDownload.isNotEmpty && !links.cvDownload.startsWith('TODO_');
    if (hasLegacyCv) {
      return _CvDownloadSelection(
        url: links.cvDownload,
        language: AppLanguage.en,
      );
    }
    return _CvDownloadSelection.empty;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalization(_selectedLanguage);

    switch (_controller.status) {
      case PortfolioStatus.loading:
        return const Scaffold(body: LoadingSkeleton());
      case PortfolioStatus.error:
        return Scaffold(
          body: ErrorState(
            message: _controller.errorMessage,
            onRetry: _controller.load,
            retryLabel: i18n.retry,
          ),
        );
      case PortfolioStatus.ready:
        final bundle = _controller.bundle!;
        final cvSelection = _resolveCvSelection(bundle.profile.links);

        return Scaffold(
          body: Stack(
            children: [
              const _BackgroundGlow(),
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 82,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: SafeArea(
                      child: AppNavBar(
                        profile: bundle.profile,
                        i18n: i18n,
                        cvLanguage: cvSelection.language,
                        onToggleLanguage: _toggleLanguage,
                        onDownloadCv: cvSelection.hasValue
                            ? () => launchExternalLink(cvSelection.url)
                            : null,
                        onScrollToSection: _scrollToSection,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1240),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeroSection(
                                  profile: bundle.profile,
                                  i18n: i18n,
                                  selectedCvLanguage: cvSelection.language,
                                  onDownloadCv: cvSelection.hasValue
                                      ? () =>
                                            launchExternalLink(cvSelection.url)
                                      : null,
                                  onProjectsTap: () =>
                                      _scrollToSection('projects'),
                                  onContactTap: () =>
                                      _scrollToSection('contacts'),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['about'],
                                  delayMs: 50,
                                  child: AboutSection(
                                    profile: bundle.profile,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['stack'],
                                  delayMs: 80,
                                  child: TechStackSection(
                                    profile: bundle.profile,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['experience'],
                                  delayMs: 110,
                                  child: ExperienceSection(
                                    items: bundle.experience,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['projects'],
                                  delayMs: 130,
                                  child: ProjectsSection(
                                    items: bundle.projects,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['education'],
                                  delayMs: 150,
                                  child: EducationSection(
                                    profile: bundle.profile,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['achievements'],
                                  delayMs: 170,
                                  child: AchievementsSection(
                                    items: bundle.achievements,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  child: SoftSkillsSection(
                                    profile: bundle.profile,
                                    i18n: i18n,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                AnimatedReveal(
                                  key: _sectionKeys['contacts'],
                                  delayMs: 190,
                                  child: ContactSection(
                                    profile: bundle.profile,
                                    i18n: i18n,
                                    selectedCvLanguage: cvSelection.language,
                                    onDownloadCv: cvSelection.hasValue
                                        ? () => launchExternalLink(
                                            cvSelection.url,
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
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

class _CvDownloadSelection {
  const _CvDownloadSelection({required this.url, required this.language});

  final String url;
  final AppLanguage language;

  bool get hasValue => url.isNotEmpty;

  static const empty = _CvDownloadSelection(url: '', language: AppLanguage.en);
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            AppPalette.background,
            AppPalette.secondary.withOpacity(0.45),
            AppPalette.background,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -190,
            left: -110,
            child: _GlowCircle(
              size: 400,
              colors: [
                AppPalette.primary.withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
          Positioned(
            top: 250,
            right: -120,
            child: _GlowCircle(
              size: 320,
              colors: [AppPalette.accent.withOpacity(0.12), Colors.transparent],
            ),
          ),
          Positioned(
            bottom: -140,
            left: -80,
            child: _GlowCircle(
              size: 280,
              colors: [
                AppPalette.warning.withOpacity(0.08),
                Colors.transparent,
              ],
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
