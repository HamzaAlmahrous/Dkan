import 'package:dkan/views/language/language_screen.dart';
import 'package:dkan/views/login/login_screen.dart';
import 'package:dkan/views/on_boarding/on_boarding_screen.dart';
import 'package:dkan/views/shop_layout/dkan_layout.dart';
import 'package:flutter/material.dart';

class Wrapper {
  static Widget start({String? token, bool? onBarding}) {
    
    Widget? startWidget;
    
    if (onBarding != null) {
      if (token != null) {
        startWidget = const DkanLayout();
      } else {
        startWidget = LanguageScreen();
      }
    } else {
      startWidget = const OnBoarding();
    }
    return startWidget;
  }
}
