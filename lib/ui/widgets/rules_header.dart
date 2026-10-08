import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const RulesHeader({
  required final VoidCallback onPressed, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 40),
          child: DecoratedBox(
            decoration: const ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(color: AppThemes.white)
              ),
            ),
            child: IconButton(
              onPressed: onPressed,
              style: IconButton.styleFrom(
                highlightColor: AppThemes.white.withValues(alpha: 0.1)
              ),
              icon: const Icon(
                Icons.arrow_back_outlined, 
                color: AppThemes.white
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "Como Jogar",
          style: TextStyle(
            fontSize: 22, 
            fontWeight: .bold,
            color: AppThemes.white
          ),
        ),
      ],
    );
  }
}
