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
  List<Widget> chickens = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _controller.forward();
    chickens.add(AnimatedChicken(key: UniqueKey()));
  }

  void addChicken() {
    setState(() {
      // Dodaj nowego kurczaka do listy, każdy z unikalnym kluczem
      chickens.add(AnimatedChicken(key: UniqueKey()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: const <Widget>[
            AnimatedEgg(
              margin: EdgeInsets.only(right: 100),
            ),
            AnimatedEgg(
              margin: EdgeInsets.only(right: 1500),
            ),            
            JumpingBunny(offset: 0, delay: 0),
            JumpingBunny(offset: 200, delay: 1500),
            JumpingBunny(offset: 400, delay: 0),
            JumpingBunny(offset: 600, delay: 1500),
            JumpingBunny(offset: 800, delay: 0),
            JumpingBunny(offset: 1000, delay: 1500),
            JumpingBunny(offset: 1200, delay: 0),
            JumpingBunny(offset: 1400, delay: 1500),
            JumpingBunny(offset: 1600, delay: 0),
            AnimatedTextWidget()
          ] + chickens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addChicken,
        child: Icon(Icons.add),
      ),
    );
  }
}

