import 'package:flutter/material.dart';

class AnimatedEgg extends StatefulWidget {
  const AnimatedEgg({Key? key}) : super(key: key);

  @override
  _AnimatedEggState createState() => _AnimatedEggState();
}

class _AnimatedEggState extends State<AnimatedEgg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 0.5), weight: 50),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.centerRight,
          child: Transform.scale(
            scale: _sizeAnimation.value,
            child: Image.asset('assets/images/Easter-Egg.webp', width: 200),
          ),
        );
      },
    );
  }
}
