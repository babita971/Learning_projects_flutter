// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minimalist_music_player/constants.dart';
import 'package:minimalist_music_player/model/audio_metadata.dart';
import 'package:minimalist_music_player/widgets/music_controls.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  double padding = defaultPadding * 2;
  int currentIndex = 0;
  late ConcatenatingAudioSource _playlist;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Future<void> _init() async {
    _playlist = ConcatenatingAudioSource(children: audioSource);
    _player.sequenceStateStream.listen((event) {
      setState(() {
        currentIndex = event?.currentIndex ?? 0;
      });
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          buildGradientBackgroundWidget(),
          buildPlayerCard(),
          buildPlayerContent()
        ],
      ),
      floatingActionButton: Tooltip(
        message: 'Change Theme',
        child: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          child: Container(
            width: 60,
            height: 60,
            child: Icon(Icons.change_circle,
                // size: 40,
                color: audioSource[currentIndex].tag!.backgroundColors[0]),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: audioSource[currentIndex]
                    .tag!
                    .backgroundColors, //getColorsList,
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              currentIndex = currentIndex != 2 ? currentIndex + 1 : 0;
            });
          },
        ),
      ),
    );
  }

  late Listenable controller;
  Widget buildGradientBackgroundWidget() {
    print('backgr ${audioSource[currentIndex].tag!.backgroundColors}');
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors:
              audioSource[currentIndex].tag!.backgroundColors, //getColorsList,
          tileMode: TileMode.clamp,
        ),
        // gradient: background
        //           .evaluate(AlwaysStoppedAnimation(currentIndex/audioSource.length)),
      ),
    );
  }

  Widget buildPlayerCard() {
    return Positioned(
      top: Get.height * 0.5,
      child: FractionalTranslation(
        translation: Offset(0, -0.5),
        child: Stack(
          children: [
            Positioned(
              width: cardWidth,
              height: minCardHeight * 0.5,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1F4D6FDE),
                      blurRadius: 20,
                      offset: Offset(20, 20),
                    ),
                    BoxShadow(
                      color: Color(0x1F4D6FDE),
                      blurRadius: 20,
                      offset: Offset(-20, 20),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                width: cardWidth,
                height: minCardHeight,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: audioSource[currentIndex]
                          .tag!
                          .backgroundColors, //getColorsList,
                      tileMode: TileMode.clamp,
                    )
                    // TODO: gradient: background.evaluate(AlwaysStoppedAnimation(currentIndex!/audioSource.length))
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildArtWork(String artwork) {
    if (artwork.isEmpty) return SizedBox();
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: Container(
        height: artWorkDiameter,
        width: artWorkDiameter,
        key: Key(artwork),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(artwork),
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 40,
              color: Color(0x142196F3),
              offset: Offset(0, 40),
            ),
          ],
        ),
      ),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: animation,
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  Widget buildMetaData() {
    return StreamBuilder<SequenceState?>(
      stream: _player.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) return SizedBox();
        final metadata = state!.currentSource!.tag as AudioMetadata;
        print('meta build');
        print(state.sequence);
        // print(metadata.artwork);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildArtWork(metadata.artwork),
            buildTitle(metadata.title),
            buildArtist(metadata.artist)
          ],
        );
      },
    );
  }

  Widget buildPlayerContent() {
    double posY = Get.height / 2 - (minCardHeight / 2 + artWorkDiameter / 2);
    return Positioned(
      top: posY,
      width: cardWidth - (padding * 2),
      child: Column(
        children: [
          buildMetaData(),
          SizedBox(
            height: defaultPadding * 2,
          ),
          MusicControls(player: _player)
        ],
      ),
    );
  }

  Widget buildTitle(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        switchInCurve: Curves.bounceIn,
        child: Text(
          title,
          style: kSongTitleTextStyle,
          key: Key(title),
        ),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget buildArtist(title) {
    print('artist $title');
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        switchInCurve: Curves.bounceIn,
        child: Text(title, style: kSongArtistTextStyle),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
