import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter1 = 1;
  int _counter2 = 2;

  rollDice1() {
    setState(() {
      _counter1 = Random().nextInt(5) + 1; //From 0(inclusive) to 5
    });
  }

  rollDice2() {
    setState(() {
      _counter2 = Random().nextInt(5) + 1; //From 0(inclusive) to 5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dicee",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff023047),
      ),
      backgroundColor: Colors.indigoAccent[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      rollDice1();
                    },
                    child:
                        Image(image: AssetImage("assets/dice$_counter1.png")),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      rollDice2();
                    },
                    child:
                        Image(image: AssetImage("assets/dice$_counter2.png")),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
