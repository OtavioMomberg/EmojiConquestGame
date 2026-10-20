import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/widgets/border_button.dart';

class const HelpButton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        CustomFeedback.rawDialog(
          context: context,
          backgroundColor: AppColors.gray,
          shadowColor: AppColors.gray,
          title: Center(
            child: const Text(
              "Ajuda",
              style: TextStyle(color: AppColors.white),
            ),
          ),
          content: Column(
            spacing: 10,
            mainAxisSize: .min,
            children: <Widget>[
              Row(
                spacing: 10,
                mainAxisAlignment: .center,
                children: <Widget>[
                  Expanded(
                    child: BorderButton(
                      screen: AppRoutes.emojis,
                      label: "Emojis",
                    ),
                  ),
                  Expanded(
                    child: BorderButton(
                      screen: AppRoutes.classes,
                      label: "Classes",
                    ),
                  ),
                ],
              ),
              const Text(
                "Também é possível clicar e segurar no emoji que deseja ver as informações!",
                style: TextStyle(color: AppColors.white),
              ),
            ]
          )
        );
      },
      icon: const Icon(
        Icons.help_outline_outlined, 
        color: AppColors.white
      ),
    );
  }
}