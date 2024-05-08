import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playAudio(int audioNumber) {
    final player = AudioCache();
    player.play('note$audioNumber.wav');
    print('audio number $audioNumber');
  }

  Widget buildWidgetKey({int audioFile = 1, Color color = Colors.blue}) {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        color: color,
        child: Text(''),
        onPressed: () {
          playAudio(audioFile);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.black,
        //   title: Text('Play your notes!'),
        // ),
        backgroundColor: Colors.red[900],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildWidgetKey(audioFile: 1, color: Colors.red),
              buildWidgetKey(audioFile: 2, color: Colors.orange),
              buildWidgetKey(audioFile: 3, color: Colors.yellow),
              buildWidgetKey(audioFile: 4, color: Colors.green),
              buildWidgetKey(audioFile: 5, color: Colors.teal),
              buildWidgetKey(audioFile: 6, color: Colors.blue),
              buildWidgetKey(audioFile: 7, color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
