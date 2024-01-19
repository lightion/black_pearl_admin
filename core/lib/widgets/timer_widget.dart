import 'package:core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration duration;

  const TimerWidget({super.key, required this.duration});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    final totalTime = widget.duration.inMinutes * 60;
    return TweenAnimationBuilder(
        tween: Tween(begin: widget.duration, end: Duration.zero),
        duration: widget.duration,
        builder: (context, value, child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;

          final percentageTime = ((minutes * 60 + seconds) / totalTime);
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: CircularProgressIndicator(
                    value: percentageTime,
                  ),
                ),
                Text(
                  "$minutes:$seconds",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
