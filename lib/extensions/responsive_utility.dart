import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  bool get isMobileScreen {
    return MediaQuery.of(this).size.width <= 900;
  }

  bool get isLaptopScreen {
    var width = MediaQuery.of(this).size.width;
    return width > 900 && width <= 1200;
  }

  bool get isDesktopScreen {
    return MediaQuery.of(this).size.width > 1200;
  }

}