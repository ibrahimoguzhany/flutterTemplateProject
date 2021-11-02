import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../enum/lottie_path_enum.dart';

extension LottiePathEnumExtension on LottiePathEnum {
  String get rawValue {
    switch (this) {
      case LottiePathEnum.MOON:
        return _pathValue("moon-stars");

      case LottiePathEnum.SUNNY:
        return _pathValue('sunny');
    }
  }

  Widget get toWidget {
    return Lottie.asset(this.rawValue);
  }

  String _pathValue(String path) => 'assets/lottie/$path.json';
}
