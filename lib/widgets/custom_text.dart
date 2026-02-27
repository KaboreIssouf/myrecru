import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight weight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const CustomText._(
      this.text, {
        this.size = 16.0,
        this.color,
        required this.weight,
        this.textAlign,
        this.decoration,
        this.decorationColor,
      });


  factory CustomText.light(String text, {double size = 16.0, Color? color, TextAlign? textAlign}) {
    return CustomText._(text, weight: FontWeight.w300, size: size, color: color, textAlign: textAlign);
  }

  factory CustomText.regular(String text, {double size = 16.0, Color? color, TextAlign? textAlign}) {
    return CustomText._(text, weight: FontWeight.w400, size: size, color: color, textAlign: textAlign);
  }

  factory CustomText.bold(String text, {double size = 18.0, Color? color, TextAlign? textAlign,   TextDecoration? decoration}) {
    return CustomText._(text, weight: FontWeight.w700, size: size, color: color, textAlign: textAlign,  decoration: decoration,  decorationColor: color,);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: size,
        color: color ?? Colors.black,
        fontWeight: weight,
        decoration: decoration,
          decorationColor: decorationColor
      ),
    );
  }
}