import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({super.key});

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: List.generate(7, (index) {
            final t = (_controller.value + index * 0.07) % 1;
            final alpha = 0.15 + (0.2 * (1 - (t - 0.5).abs() * 2));
            return Container(
              height: 118,
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: AppPalette.secondary.withOpacity(
                  alpha.clamp(0.15, 0.32),
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppPalette.border.withOpacity(0.7)),
              ),
            );
          }),
        );
      },
    );
  }
}
