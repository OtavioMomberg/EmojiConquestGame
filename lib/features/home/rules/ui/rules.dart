import 'package:drag_and_drop_game/features/home/rules/data/rules_data.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const Rules({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_,_) => const SizedBox(height: 10), 
      itemCount: RulesData.rules.length,
      itemBuilder: (context, index) {
        return Material(
          color: AppColors.grayBluish.withValues(alpha: .3),
          shape: RoundedRectangleBorder(
            borderRadius: AppThemes.stdBorderRadius
          ),
          child: ListTile(
            title: Text(
              RulesData.rules[index],
              style: const TextStyle(
                color: AppColors.white
              ),
            ),
          )
        );
      } 
    );
  }
}
