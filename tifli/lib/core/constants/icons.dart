// lib/icons.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String bottle = 'assets/icons/feeding-bottle.svg';

  static Widget svg(String path, {double size = 32, Color? color}) =>
      SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      );
}
