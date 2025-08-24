import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScrollForMore extends StatefulWidget {
  const ScrollForMore({super.key});

  @override
  ScrollForMoreState createState() => ScrollForMoreState();
}

class ScrollForMoreState extends State<ScrollForMore>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 8)
        .chain(CurveTween(curve: Curves.easeInOutSine))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Column(
            children: [
              Text(
                'Scroll for more',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Transform.rotate(
                angle: math.pi,
                child: const Icon(Icons.keyboard_arrow_up, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
