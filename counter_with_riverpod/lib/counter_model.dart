import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _counter = 0;
  int get getCounter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
