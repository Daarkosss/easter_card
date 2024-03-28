import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';


class AnimatedChicken extends StatefulWidget {

  const AnimatedChicken({Key? key}) : super(key: key);

  @override
  _AnimatedChickenState createState() => _AnimatedChickenState();
}
class _AnimatedChickenState extends State<AnimatedChicken> with TickerProviderStateMixin {
  late AnimationController _controller;
  final audioPlayer = AudioPlayer();
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _moveToCenterAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _moveToEndAnimation;

  @override
  void initState() {
    super.initState();
    final random = Random();
    final durationSeconds = random.nextInt(9) + 4; // Generuje liczbę od 4 do 12

    _controller = AnimationController(
      duration: Duration(seconds: durationSeconds),
      vsync: this,
    );

    Future<void> playSound() async {
      final player = AudioCache(prefix: 'assets/audio/');
      final url = await player.load('chicken-sound.mp3');
      audioPlayer.play(url.path, isLocal: true);
    }

    // Animacja przezroczystości (pojawienie się)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.1, curve: Curves.easeIn),
      ),
    );

    // Animacja przesunięcia do środka ekranu
    _moveToCenterAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(2.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Animacja skalowania
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Animacja przesunięcia do końca ekranu i zniknięcia
    _moveToEndAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0),
      end: const Offset(5.5, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
    playSound();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = 1.0;
        if (_controller.value > 0.5 && _controller.value <= 0.7) {
          scale = _scaleAnimation.value;
        } else if (_controller.value > 0.7) {
          scale = 2.0; // Utrzymanie skali po powiększeniu
        }

        return Transform.translate(
          offset: Offset(0, 100), // Przesuwa cały widget 50px w dół
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: scale,
              child: FractionalTranslation(
                translation: _controller.value <= 0.5
                    ? _moveToCenterAnimation.value
                    : _moveToEndAnimation.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Image.asset('assets/images/chicken.png', width: 200),
    );
  }
}
