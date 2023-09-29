import 'package:flutter/material.dart';
import 'dart:async';

class CurrentTime extends StatefulWidget {
  const CurrentTime({Key? key}) : super(key: key);

  @override
  State<CurrentTime> createState() => CurrentTimeState();
}

class CurrentTimeState extends State<CurrentTime> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();

    // Start a timer that updates the time every second
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    final now = DateTime.now();
    final hour = now.hour;
    final period = hour < 12 ? 'AM' : 'PM';
    final formattedHour = hour <= 12 ? hour : hour - 12;
    final upsecond = now.second < 10 ? '0${now.second}' : now.second;
    final upminute = now.minute < 10 ? '0${now.minute}' : now.minute;
    final formattedTime = "$formattedHour:${upminute}:${upsecond} $period";
    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _currentTime,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
