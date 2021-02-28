import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final Color color;

  BaseText(
    this.text, {
    this.fontSize = 16,
    this.isBold = false,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: this.fontSize,
        fontWeight: this.isBold ? FontWeight.bold : FontWeight.normal,
        color: this.color,
      ),
    );
  }
}
