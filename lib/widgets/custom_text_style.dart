import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle light({double size = 16.0, Color? color}) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w300,
      fontSize: size,
      color: color ?? Colors.black,
    );
  }

  static TextStyle regular({double size = 16.0, Color? color}) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bold({double size = 18.0, Color? color, TextDecoration? decoration}) {
    return TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w700,
      fontSize: size,
      color: color ?? Colors.black,
      decoration: decoration,
      decorationColor: color,
    );
  }
}