import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const SortButton({ super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: AppThemes.stdBorderRadius,
      color: AppThemes.white,
      child: InkWell(
        onTap: () {},
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
                  fontWeight: .bold
                )
              ),
              Icon(Icons.shuffle, color: AppThemes.gray)
            ]
          )  
        )
      )
    );
  }
}