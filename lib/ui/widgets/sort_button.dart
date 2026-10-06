import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class SortButton extends StatelessWidget {
  final Future<void> Function() onTap;

  const SortButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: AppThemes.stdBorderRadius,
      color: AppThemes.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppThemes.stdBorderRadius,
        splashColor: AppThemes.lightGray2,
        child: const SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children:  <Widget>[
              Icon(Icons.shuffle, color: AppThemes.gray),
              Text(
                "SORTEAR", 
                style: TextStyle(
                  color: AppThemes.gray, 
                  fontWeight: .w600)
                ),
              Icon(Icons.shuffle, color: AppThemes.gray)
            ]
          )  
        )
      )
    );
  }
}