// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minimalist_music_player/constants.dart';
import 'package:minimalist_music_player/model/audio_metadata.dart';
import 'package:minimalist_music_player/modules/home/controller/home_controller.dart';
import 'package:minimalist_music_player/widgets/music_controls.dart';

class HomePage extends GetView<HomeController> with WidgetsBindingObserver {
  double padding = defaultPadding * 2;
  HomeController homeController = Get.find();

  Widget buildShadowToggle() {
    return Positioned(
      top: 20,
      left: 20,
      child: Obx(
        () => FlutterSwitch(
          width: 45.0,
          height: 20.0,
          valueFontSize: 25.0,
          toggleSize: 22.0,
          value: homeController.showCard.value,
          borderRadius: 14.0,
          padding: 2.0,
          inactiveColor: Color(0x70FFFFFF),
          activeColor: Color(0xA8FFFFFF),
          onToggle: (val) {
            homeController.updateFlutterSwitchToggle(val);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              buildGradientBackgroundWidget(),
              homeController.showCard.value ? buildPlayerCard() : SizedBox(),
              buildPlayerContent(),
              buildShadowToggle()
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
                    color: homeController
                        .audioSources[homeController.currentIndex.value]
                        .tag!
                        .backgroundColors[0]),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: homeController
                        .audioSources[homeController.currentIndex.value]
                        .tag!
                        .backgroundColors, //getColorsList,
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
              onPressed: () {
                homeController.updateCurrentIndex();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGradientBackgroundWidget() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: homeController.audioSources[homeController.currentIndex.value]
              .tag!.backgroundColors, //getColorsList,
          tileMode: TileMode.clamp,
        ),
        // gradient: background
        //           .evaluate(AlwaysStoppedAnimation(currentIndex/audioSource.length)),
      ),
    );
  }

  Widget buildPlayerCard() {
    return Positioned(
      top: Get.height * 0.5 - minCardHeight / 2,
      child: Stack(
        children: [
          Positioned(
            width: cardWidth,
            height: homeController.cardHeight.value * 0.5,
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
              height: homeController.cardHeight.value,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: homeController
                        .audioSources[homeController.currentIndex.value]
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
      stream: homeController.player.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) return SizedBox();
        final metadata = state!.currentSource!.tag as AudioMetadata;
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
    double posY = Get.height / 2 -
        (homeController.cardHeight.value / 2 + artWorkDiameter / 2);
    return Positioned(
      top: posY,
      width: cardWidth - (padding * 2),
      child: Column(
        children: [
          buildMetaData(),
          SizedBox(
            height: defaultPadding * 2,
          ),
          MusicControls(
            player: homeController.player,
            onChange: (height) {
              homeController.updatePlayerCardHeight(height);
            },
          )
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
