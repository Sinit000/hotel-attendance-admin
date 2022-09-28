import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

Widget delayedWidget(
    {required child,
    Duration delay = Duration.zero,
    Duration fadingDuration = const Duration(milliseconds: 400)}) {
  return DelayedDisplay(
      delay: delay, fadingDuration: fadingDuration, child: child);
}
