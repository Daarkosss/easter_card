import 'package:flutter/material.dart';

class AnimatedChicken extends StatefulWidget {
  const AnimatedChicken({Key? key}) : super(key: key);

  @override
  _AnimatedChickenState createState() => _AnimatedChickenState();
}

class _AnimatedChickenState extends State<AnimatedChicken> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Czas trwania animacji
      vsync: this,
    )..repeat(reverse: true); // Zapętlenie animacji

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Początkowe przesunięcie poza lewą krawędź ekranu
      end: const Offset(1, 0), // Końcowe przesunięcie poza prawą krawędź ekranu
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // Liniowa krzywa animacji
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Image.asset('assets/images/chicken.png', width: 100),
    );
  }
}
