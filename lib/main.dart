import 'package:flutter/material.dart';
import 'easter_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Naciśnij przycisk, aby odtworzyć kartkę wielkanocną!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EasterCard()),
                );
              },
              child: Icon(Icons.play_arrow),
              tooltip: 'Start',
            ),
          ],
        ),
      ),
    );
  }
}
