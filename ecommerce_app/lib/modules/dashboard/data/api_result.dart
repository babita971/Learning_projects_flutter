import 'package:ecommerce_app/modules/dashboard/modal/kicker_model.dart';
import 'package:flutter/material.dart';

class ApiResult {
  //Let's assume following data from api result
  final List<KickerModel> _allKickerModels = [
    KickerModel(
        kickerPid: 1,
        kickerImage: 'images/klipartz 1.png',
        kickerName: 'Nike Air Pegasus',
        kickerDescription:
            'Limited edition nike sneakers, marketed in 2021 over 20+ countries globally',
        kickerPrice: 200.99,
        kickerStars: 4.5,
        kickerColor: Colors.red,
        kickerSales: 1200,
        kickerAvailableColors: [
          Colors.red,
          Colors.yellow,
          Colors.blue[900],
          Colors.black
        ]),
    KickerModel(
        kickerPid: 2,
        kickerImage: 'images/klipartz 2.png',
        kickerName: 'Jordan Jump XV',
        kickerDescription:
            'Limited edition nike sneakers, marketed in 2021 over 20+ countries globally',
        kickerPrice: 120.99,
        kickerStars: 4,
        kickerColor: Colors.black,
        kickerAvailableColors: [Colors.red, Colors.brown, Colors.black],
        kickerSales: 5000),
    KickerModel(
        kickerPid: 3,
        kickerImage: 'images/klipartz 5.png',
        kickerName: 'Nike Raptor',
        kickerDescription:
            'Limited edition nike sneakers, marketed in 2021 over 20+ countries globally',
        kickerPrice: 260.99,
        kickerStars: 5,
        kickerColor: Colors.red,
        kickerAvailableColors: [
          Colors.red,
          Colors.deepPurple,
          Colors.grey,
          Colors.black
        ],
        kickerSales: 1800),
    KickerModel(
      kickerPid: 4,
      kickerImage: 'images/klipartz 6.png',
      kickerName: 'Basketball Jordans',
      kickerDescription:
          'Limited edition nike sneakers, marketed in 2021 over 20+ countries globally',
      kickerPrice: 110.99,
      kickerStars: 4.5,
      kickerColor: Colors.black,
      kickerAvailableColors: [Colors.orange, Colors.green[900], Colors.black],
      kickerSales: 8000,
    )
  ];

  getAllKickerModals() {
    return _allKickerModels;
  }

  getAllKickerModalsByID(int orderPid) {
    final index =
        _allKickerModels.indexWhere((element) => element.kickerPid == orderPid);
    if (index >= 0) {
      return _allKickerModels[index];
    }
  }
}
