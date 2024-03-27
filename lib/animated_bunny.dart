import 'package:flutter/material.dart';

class JumpingBunny extends StatefulWidget {
  const JumpingBunny({Key? key}) : super(key: key);

  @override
  _JumpingBunnyState createState() => _JumpingBunnyState();
}

class _JumpingBunnyState extends State<JumpingBunny> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _jumpAnimation = Tween<double>(begin: 0, end: -50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _jumpAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _jumpAnimation.value),
          child: child,
        );
      },
      child: Image.asset('assets/images/bunny.png', width: 100),
    );
  }
}

class FadingBunny extends StatefulWidget {
  const FadingBunny({Key? key}) : super(key: key);

  @override
  _FadingBunnyState createState() => _FadingBunnyState();
}

class _FadingBunnyState extends State<FadingBunny> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Image.asset('assets/images/bunny.png', width: 100),
    );
  }
}
