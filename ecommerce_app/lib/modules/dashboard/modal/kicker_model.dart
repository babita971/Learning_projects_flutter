import 'package:flutter/material.dart';

class KickerModel {
  final String kickerImage;
  final String kickerName;
  final String kickerDescription;
  final double kickerPrice;
  final double kickerStars;
  final int kickerSales;
  int kickerQuantity;
  var isAddedToCart = false;
  final int kickerPid;
  final Color kickerColor;
  final List<Color?> kickerAvailableColors;

  KickerModel(
      {this.kickerPid = 0,
      this.kickerImage = '',
      this.kickerName = '',
      this.kickerPrice = 0,
      this.kickerStars = 0.0,
      this.kickerSales = 0,
      this.kickerDescription = '',
      this.kickerColor = Colors.white,
      this.kickerAvailableColors = const [],
      this.kickerQuantity = 1,
      this.isAddedToCart = false});
}
