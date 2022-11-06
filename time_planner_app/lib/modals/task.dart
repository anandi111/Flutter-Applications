import 'package:flutter/material.dart';

class Task {
  Color color;
  int day;
  int hour;
  int minute;
  int minutesDuration;
  int daysDuration;
  String task;

  Task({
    required this.color,
    required this.day,
    required this.hour,
    required this.minute,
    required this.minutesDuration,
    required this.daysDuration,
    required this.task,
  });
}
