import 'package:flutter/material.dart';

class Additional extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;

  Additional(
      {super.key,
      required this.icon,
      required this.label,
      required this.detail});

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
