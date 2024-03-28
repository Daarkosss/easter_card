import 'package:flutter/material.dart';

class AnimatedEgg extends StatefulWidget {
  final EdgeInsets margin;

  const AnimatedEgg({
    Key? key,
    this.margin = EdgeInsets.zero, // Domyślnie brak marginesu
  }) : super(key: key);

  @override
  _AnimatedEggState createState() => _AnimatedEggState();
}


class _AnimatedEggState extends State<AnimatedEgg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _rotationAnimation; // Dodajemy animację obrotu

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

    // Definicja animacji obrotu
    _rotationAnimation = Tween<double>(begin: 0, end: 3.14).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: widget.margin, // Ustaw margines
          child: Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _sizeAnimation.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Image.asset('assets/images/Easter-Egg.webp', width: 300),
    );
  }
}
