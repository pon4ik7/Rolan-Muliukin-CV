import 'package:flutter/material.dart';

class AnimatedReveal extends StatefulWidget {
  const AnimatedReveal({required this.child, super.key, this.delayMs = 0});

  final Widget child;
  final int delayMs;

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.05),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
