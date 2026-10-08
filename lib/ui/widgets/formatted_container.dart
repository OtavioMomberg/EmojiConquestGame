import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const FormattedContainer({final Widget? child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .infinity,
      width: .infinity,
      padding: const .symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(gradient: AppThemes.gradient),
      child: child,
    );
  }
}