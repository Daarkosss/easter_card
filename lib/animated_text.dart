import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({Key? key}) : super(key: key);

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation; // Dodajemy animację koloru

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Inicjalizacja animacji koloru
    _colorAnimation = ColorTween(
      begin: Color.fromARGB(255, 255, 208, 0),
      end: Color.fromARGB(255, 0, 242, 250),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _sizeAnimation.value,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // Dodaje odstępy wokół tekstu
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4), // Półprzezroczyste tło dla tekstu
              child: Text(
                'Smacznego jajka i mokrego dyngusa!',
                style: TextStyle(
                  fontSize: 40,
                  color: _colorAnimation.value, // Tutaj jest używana animacja koloru tekstu
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

