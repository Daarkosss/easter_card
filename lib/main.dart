import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          title: Text('Wesołych Świąt Wielkanocnych!'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: EasterCard(),
        ),
      ),
    );
  }
}

class EasterCard extends StatefulWidget {
  const EasterCard({Key? key}) : super(key: key);

  @override
  _EasterCardState createState() => _EasterCardState();
}

class _EasterCardState extends State<EasterCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: Image.asset('assets/images/Easter-Egg.webp')
    );
  }
}
