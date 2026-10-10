import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const Field({super.key}) extends StatefulWidget {
  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (_, item, _) {
        return AnimatedScale(
          scale: item.isNotEmpty ? 1.05 : 1.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          child: Card(
            color: AppColors.orange,
            elevation: 5,
            shadowColor: AppColors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: AppThemes.stdBorderRadius,
            ),
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: <Widget>[
                Text(
                  "CAMPO",
                  style: AppThemes.fieldTextStyle
                ),
                Text(
                  "X: 100 / Y: 100",
                  style: AppThemes.fieldTextStyle
                )
              ]
            )
          )
        );
      },
      onAcceptWithDetails: (details) {}
    );
  }
}
