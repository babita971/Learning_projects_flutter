import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minimalist_music_player/model/audio_metadata.dart';

class AudioDataSources {
  final _allAudioSources = [
    AudioSource.uri(
      Uri.parse("asset:///audios/Shiloh Dynasty Imagination.mp3"),
      tag: AudioMetadata(
          album: "LoFi",
          title: "Imagination",
          artwork:
              "https://wallpapers.com/images/high/aesthetic-profile-picture-anime-boy-art-sfacqyfqe8ulwvho.jpg",
          artist: 'Shiloh Dynasty',
          backgroundColors: [
            const Color(0xFFE8F7FF),
            const Color(0xFF8BD1FF),
          ]),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audios/timmies - soft skin (ft. shiloh).mp3"),
      tag: AudioMetadata(
          album: "LoFi",
          title: "Soft skin LoFi",
          artwork:
              "https://i.pinimg.com/736x/04/08/42/04084232214b271596efd65d2e73f430.jpg",
          artist: 'Timmies',
          backgroundColors: [
            const Color(0xFFE6F5FD),
            const Color(0xFFFBC1EA),
          ]),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audios/The Most Beautiful Thing.mp3"),
      tag: AudioMetadata(
          album: "LoFi",
          title: "Dandelions",
          artwork: "https://data.whicdn.com/images/301852974/original.jpg",
          artist: 'Ruth B',
          backgroundColors: [
            const Color(0xFFFDB5C0),
            const Color(0xFFA7CCE9),
          ]),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audios/The Most Beautiful Thing.mp3"),
      tag: AudioMetadata(
          album: "LoFi",
          title: "Beautiful thing",
          artwork:
              "https://i.pinimg.com/564x/be/94/58/be9458b33bb8c1f9fbb532ab4ce316ac.jpg",
          artist: 'Bruno Major',
          backgroundColors: [
            const Color(0xFFF8E6D7),
            const Color(0xFFA0D8A3),
          ]),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audios/The Most Beautiful Thing.mp3"),
      tag: AudioMetadata(
          album: "LoFi",
          title: "Until I found you",
          artwork:
              "https://i.pinimg.com/originals/4c/79/d4/4c79d46b3af752305524315b89d5e091.png",
          artist: 'Stephen Sanchez',
          backgroundColors: [
            const Color(0xFFDA9CF1),
            const Color(0xFFFAE69B),
          ]),
    ),
  ];

  getAllAudioSources() {
    return _allAudioSources;
  }
}
