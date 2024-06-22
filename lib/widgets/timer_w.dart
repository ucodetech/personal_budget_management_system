import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final String initialMessage;
  final Duration duration;
  final bool color_status;

  TimerWidget({required this.initialMessage, required this.duration, required this.color_status});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late String message;
  late bool ColorStatus;

  @override
  void initState() {
    super.initState();
    message = widget.initialMessage;
    ColorStatus = widget.color_status;
    _startTimer();
  }

  void _startTimer() {
    if (message.isNotEmpty) {
      Timer(widget.duration, () {
        setState(() {
          message = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: message.isNotEmpty
          ? Text(
        message,
        style: TextStyle(
            fontSize: 18,
            color: ColorStatus ? Colors.green : Colors.red
        ),
      )
          : Container(),
    );
  }
}
