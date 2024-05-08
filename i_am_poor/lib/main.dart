import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('I am Poor'),
            backgroundColor: Colors.cyan[900],
          ),
          backgroundColor: Colors.blue[400],
          body: Center(
            child: Image(
              image: AssetImage('assets/coal.png'),//NetworkImage('https://img.icons8.com/ios-glyphs/452/coal.png'),
            ),
          )),
    ),
  );
}
