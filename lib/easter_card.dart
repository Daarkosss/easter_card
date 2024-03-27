import 'package:flutter/material.dart';
import 'animated_text.dart';
import 'animated_bunny.dart';
import 'animated_chicken.dart';
import 'animated_egg.dart';

class EasterCard extends StatefulWidget {
  const EasterCard({Key? key}) : super(key: key);

  @override
  State<EasterCard> createState() => _EasterCardState();
}

class _EasterCardState extends State<EasterCard> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: const <Widget>[
          AnimatedEgg(),
          AnimatedChicken(),
          JumpingBunny(),
          FadingBunny(),
          AnimatedTextWidget()
        ],
      ),
    );
  }
}
