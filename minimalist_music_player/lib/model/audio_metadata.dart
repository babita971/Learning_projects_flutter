import 'package:flutter/material.dart';

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;
  final String artist;
  List<Color> backgroundColors;

  AudioMetadata({
    required this.album,
    required this.title,
    required this.artwork,
    required this.artist,
    required this.backgroundColors,
  });
}
