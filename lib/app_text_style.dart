import 'package:flutter/material.dart';

TextStyle appTextStyle({
  bool isiPad = false,
  double? fontSize = 18,
  Color? color,
}) {
  return TextStyle(
    fontSize: isiPad ? 36 : fontSize,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
