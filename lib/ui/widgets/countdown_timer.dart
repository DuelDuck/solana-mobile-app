import 'dart:async';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime startDate;
  final Function() onFinish;
  const CountdownTimer({
    super.key,
    required this.startDate,
    required this.onFinish,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late final Stream<Duration> countdownStream;
  bool isInitTimer = false;

  @override
  void initState() {
    super.initState();
    countdownStream = streamRemainingTime(widget.startDate);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        isInitTimer = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: countdownStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data!.isNegative ||
            snapshot.data == Duration.zero ||
            isReverseTimerFinish(snapshot.data)) {
          return const SizedBox();
        }
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText.basic(
                text: formatDuration(snapshot.data!),
                style: ProjectFonts.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    final int days = duration.inDays;
    final int hours = duration.inHours.remainder(24);
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    List<String> parts = [];

    if (days > 0) parts.add('${days}d');
    if (hours > 0 || parts.isNotEmpty) parts.add('${hours}h');
    if (minutes > 0 || parts.isNotEmpty) parts.add('${minutes}m');
    parts.add('${seconds}s');

    return parts.join(' : ');
  }

  Stream<Duration> streamRemainingTime(DateTime delayTime) {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      final remainingDuration = delayTime.difference(DateTime.now());
      return remainingDuration;
    }).takeWhile((remainingDuration) => remainingDuration > Duration.zero);
  }

  isReverseTimerFinish(Duration? duration) {
    if (duration != null &&
        duration.inHours == 0 &&
        duration.inMinutes == 0 &&
        duration.inSeconds == 0) {
      return true;
    }
    return false;
  }
}
