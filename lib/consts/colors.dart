import 'dart:math';

import 'package:flutter/rendering.dart';

abstract class GidColorTable {
  static const primary = Color(0xFF801AE5);
  static const purpleTransparent = Color(0x8C261A33);
  static const purple = Color(0xFF261A33);
  static const purple2 = Color(0xFFB061FF);
  static const violet = Color(0xFF6A5ACD);
  static const purpleLight = Color(0xFFC283FF);
  static const purpleText = Color(0xFFAD94C7);
  static const purpleBackground = Color(0xFF40214A);
  static const systemBlack = Color(0xFF181622);
  static const greyTransparent = Color(0x8C373737);
  static const lightGreyTransparent = Color(0x33373737);
  static const lightGrey = Color(0xFFB8B8B8);
  static const purpleGradient1 = Color(0xFF4620DD);
  static const purpleGradient2 = Color(0xFF801AE5);
  static const white = Color(0xFFFFFFFF);
  static const systemBlack2 = Color(0xFF11111C);
  static const systemBlack3 = Color(0xFF1B1B1B);
  static const grey = Color(0xFF595959);
  static const darkGrey = Color(0xFF2A2A2A);

  /// 45-degree gradient
  static const purpleGradient45 = LinearGradient(
    colors: [
      Color(0xFF4620DD),
      Color(0xFF801AE5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// 60-degree gradient (sqrt(3) ~ 1.732)
  static const purpleGradient60 = LinearGradient(
    colors: [
      Color(0xFF4620DD),
      Color(0xFF801AE5),
    ],
    transform: GradientRotation(60 * pi / 180),
  );

  /// 30-degree gradient (sqrt(3) ~ 1.732)
  static const purpleGradient30 = LinearGradient(
    colors: [
      Color(0xFF4620DD),
      Color(0xFF801AE5),
    ],
    transform: GradientRotation(-30 * pi / 180),
  );

  static final blackGradient = LinearGradient(
    colors: [
      systemBlack.withOpacity(0),
      systemBlack,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const shinyGradient = LinearGradient(
    colors: [
      Color(0x66FFFFFF),
      Color(0x11FFFFFF),
      Color(0x11FFFFFF),
      Color(0x66FFFFFF),
    ],
    stops: [0.0, 0.22, 0.75, 1.0],
    transform: GradientRotation(40 * pi / 180),
    // begin: Alignment(-0.9848 * 1, -0.1736 * 1), // starting point (top left direction 10 degrees)
    // end: Alignment(0.984 * 1, 0.1736 * 1), // ending point (bottom right direction 10 degrees)
  );
}
