import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const SortButton({ super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: AppThemes.stdBorderRadius,
      color: AppColors.white,
      child: InkWell(
        onTap: () {},
        borderRadius: AppThemes.stdBorderRadius,
        splashColor: AppColors.lightGray2,
        child: const SizedBox(
          height: 60,
          child: Row(
            spacing: 10,
            mainAxisAlignment: .center,
            children:  <Widget>[
              Text(
                "SORTEAR", 
                style: TextStyle(
                  color: AppColors.gray, 
                  fontWeight: .bold
                )
              ),
              Icon(Icons.shuffle, color: AppColors.gray)
            ]
          )  
        )
      )
    );
  }
}