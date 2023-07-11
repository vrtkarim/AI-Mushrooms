import 'package:flutter/material.dart';

class Largetext extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  Largetext(
      {this.size = 30,
      required this.text,
      this.color = Colors.black,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
