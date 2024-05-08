import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minimalist_music_player/constants.dart';
import 'package:minimalist_music_player/data/audio_data.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var showCard = true.obs;
  final player = AudioPlayer();
  late Listenable controller;
  var cardHeight = minCardHeight.obs;
  late ConcatenatingAudioSource _playlist;
  var audioSources = AudioDataSources().getAllAudioSources();

  @override
  void onInit() {
    // WidgetsBinding.instance.addObserver(this);
    _init();
    super.onInit();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  Future<void> _init() async {
    _playlist = ConcatenatingAudioSource(children: audioSources);
    player.sequenceStateStream.listen((event) {
      currentIndex.value = event?.currentIndex ?? 0;
    });
    try {
      await player.setAudioSource(_playlist);
    } catch (e) {
      print(e);
    }
  }

  void updateFlutterSwitchToggle(val) {
    showCard.value = val;
  }

  void updateCurrentIndex() {
    currentIndex.value = currentIndex.value != 2 ? currentIndex.value + 1 : 0;
  }

  void updatePlayerCardHeight(height) {
    cardHeight.value = height;
  }
}
