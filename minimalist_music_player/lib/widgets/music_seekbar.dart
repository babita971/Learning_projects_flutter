import 'package:flutter/material.dart';

class MusicSeekBar extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final AnimationController controller;
  final double width;
  final double height;

  MusicSeekBar(
      {required this.duration,
      required this.position,
      required this.controller,
      this.height = 6,
      this.width = 300});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: SeekBarPainter(
              duration: duration, position: position, controller: controller),
        ),
      ),
    );
  }
}

class SeekBarPainter extends CustomPainter {
  final AnimationController controller;
  final Duration duration;
  final Duration position;

  SeekBarPainter(
      {required this.controller,
      required this.duration,
      required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    var total = duration.inMilliseconds;
    var current = duration.inMilliseconds;
    var centerx = size.width / 2;
    var activeTrackOpacity = 1.0;
    double progress = (current / total).toDouble();

    if (controller.isCompleted) {
      activeTrackOpacity = controller.value + 0.5;
    } else {
      activeTrackOpacity = 0.0;
    }
    canvas.drawRRect(
        RRect.fromLTRBR(
          centerx + -(size.width * controller.value),
          0.0,
          centerx + (size.width * controller.value),
          size.height,
          const Radius.circular(20),
        ),
        Paint()..color = const Color(0x8CFFFFFF));

    if (progress.isNaN) return;
    canvas.drawRRect(
        RRect.fromLTRBR(size.width * progress, 0, 0, size.height,
            const Radius.circular(20)),
        Paint()..color = Colors.white.withOpacity(activeTrackOpacity));
  }

  @override
  bool shouldRepaint(SeekBarPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(SeekBarPainter oldDelegate) => false;
}
