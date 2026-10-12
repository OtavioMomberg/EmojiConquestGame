import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/config_export.dart';

final class const ColorsCorrectionDamage._() {
  static int getCorrection({required Color color}) {
    switch (color) {
      case AppColors.blue: return 2;
      case AppColors.red: -2;
      case AppColors.green: return 1;
      case AppColors.purple: return -1;
      default: return 0;
    }
    return 0;
  }
}