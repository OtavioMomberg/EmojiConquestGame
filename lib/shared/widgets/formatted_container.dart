import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const FormattedContainer({
  final EdgeInsetsGeometry padding = AppThemes.containerStdPadding,
  final bool useSafeArea = false,
  final Widget? child, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: .infinity,
      width: .infinity,
      padding: padding,
      decoration: const BoxDecoration(
        gradient: AppThemes.gradient
      ),
      child: useSafeArea 
        ? SafeArea(child: child ?? SizedBox.shrink())
        : child
    );
  }
}