import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ColorsLogin {


  const ColorsLogin();

  static const Color loginGradientStart = const Color(0xFF212121);
  static const Color loginGradientEnd = const Color(0x00000000);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    );
}