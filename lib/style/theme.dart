import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color gradientAwal = const Color(0xFFfbab66);
  static const Color gradientAkhir = const Color(0xFFfbab66);
  static const Color backgroundLogin = const Color(0xFF089fbd);
  static const Color bacgroundButton = const Color(0xFFf45e46);
  static const Color colorTextWhite = const Color(0xFFffffff);
  static const Color backgroundAbsen = const Color(0xFF0993b8);
  static const Color colorOnLocation = const Color(0xFF5dd72e);
  static const Color colorNotOnLocation = const Color(0xFFEF5350);

  static const linearGradient = const LinearGradient(
      colors: const [gradientAwal, gradientAkhir],
      begin: Alignment.topCenter,
      stops: const [0.0, 0.1],
      end: Alignment.bottomCenter);
}
