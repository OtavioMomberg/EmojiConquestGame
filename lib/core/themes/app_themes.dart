import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

final class const AppThemes._() {
  static const black = Color.fromARGB(255, 33, 32, 32);
  static const gray = Color.fromARGB(255, 46, 46, 47);
  static const darkGray = Color.fromARGB(255, 36, 37, 39);
  static const lightGray = Color.fromARGB(255, 74, 75, 77);
  static const lightGray2 = Color.fromARGB(255, 110, 114, 123);
  static const grayBluish = Color.fromARGB(255, 82, 92, 111);
  static const white = Color.fromARGB(255, 206, 206, 207);
  static const blue = Color.fromARGB(255, 71, 112, 189);
  static const darkBlue = Color.fromARGB(255, 0, 31, 64);
  static const orange = Color.fromARGB(255, 177, 139, 84);

  static const containerStdPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 20);

  static const stdBorderRadius = BorderRadius.all(.circular(12));
  static const largerBorderRadius = BorderRadius.all(.circular(50));

  static const gradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [
      lightGray,
      gray,
      darkGray
    ]
  );

  static const systemUiOverlayStyle = SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    statusBarColor: lightGray,
    statusBarIconBrightness: .light,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: darkGray,
    systemNavigationBarIconBrightness: .light,
  );

  static final appBar = AppBar(
    toolbarHeight: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: lightGray,
    foregroundColor: white,
    systemOverlayStyle: systemUiOverlayStyle,
  );
}