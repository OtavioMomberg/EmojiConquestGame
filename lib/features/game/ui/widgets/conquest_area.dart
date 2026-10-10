import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const ConquestArea({super.key}) extends StatefulWidget {
  @override
  State<ConquestArea> createState() => _ConquestAreaState();
}

class _ConquestAreaState extends State<ConquestArea> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (_, candidateItems, _) {
        return AnimatedScale(
          scale: candidateItems.isNotEmpty ? 1.05 : 1.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          child: Card(
            color: AppThemes.orange,
            elevation: 5,
            shadowColor: AppThemes.orange,
            shape: RoundedRectangleBorder(
              borderRadius: AppThemes.stdBorderRadius,
            ),
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: <Widget>[
                Text(
                  "CAMPO",
                  style: const TextStyle(
                    color: AppThemes.white,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  "X: 100 / Y: 100",
                  style: const TextStyle(
                    color: AppThemes.white,
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
      },
    );
  }
}