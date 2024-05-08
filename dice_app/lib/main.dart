import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            'Dicee',
            // style: TextStyle(color: Colors.red),
          ),
        ),
        body: DiceHomePage(),
      ),
    ),
  );
}

class DiceHomePage extends StatefulWidget {
  @override
  _DiceHomePageState createState() => _DiceHomePageState();
}

class _DiceHomePageState extends State<DiceHomePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 2;

  void rollBothDices() {//Change both dice's UI
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  rollBothDices();
                },
                child: Image.asset('images/dice$leftDiceNumber.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            // ignore: deprecated_member_use
            child: FlatButton(
              onPressed: () {
                rollBothDices();
                // setState(() {
                //   rightDiceNumber = Random().nextInt(6) + 1;
                // });
              },
              child: Image.asset('images/dice$rightDiceNumber.png'),
            ),
          )),
        ],
      ),
    );
  }
}
