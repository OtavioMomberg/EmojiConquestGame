import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const SortButton({ 
  required final GameService gameService,
  super.key
}) extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: AppThemes.stdBorderRadius,
      color: AppColors.white,
      child: InkWell(
        onTap: gameService.selectColor,
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