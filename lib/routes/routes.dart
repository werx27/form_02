import 'package:flutter/material.dart';

import '../screens/form_screen.dart';
import '../screens/data_screen.dart';

class RouteManager {
  static const formScreen = './formScreen';
  static const dataScreen = './dataScreen';

  static Route<dynamic> generataRoute(RouteSettings settings) {
    switch (settings.name) {
      case formScreen:
        return MaterialPageRoute(
          builder: (context) => const FormScreen(),
          settings: settings,
        );

      case dataScreen:
        return MaterialPageRoute(
          builder: (context) => const DataScreen(),
          settings: settings,
        );

      default:
        throw const FormatException('Page does not exist');
    }
  }
}
