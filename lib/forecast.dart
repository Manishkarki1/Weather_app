import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final IconData icon1;
  final String time;
  final String temperature;

  Weather({required this.icon1, required this.time, required this.temperature});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
          elevation: 5.0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Icon(
                  icon1,
                  size: 32,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  temperature,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          )),
    );
  }
}
