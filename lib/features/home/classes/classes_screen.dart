import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/shared/widgets/header.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const ClassesScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        useSafeArea: true,
        child: Column(
          children: <Widget>[
            Header(
              label: "Hierarquia das Classes", 
              onPressed: () => Navigator.pop(context)
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_,_) => const SizedBox(height: 10), 
                itemCount: EmojiHierarchies.hierarchies.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: AppColors.grayBluish.withValues(alpha: .3),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppThemes.stdBorderRadius
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "Classe: ${EmojiHierarchies.hierarchies[index].type.name}\n",
                          style: const TextStyle(
                            color: AppColors.white
                          ),
                        ),
                      ),
                      subtitle: Row(
                        spacing: 15,
                        mainAxisAlignment: .center,
                        children: [
                          _IconText(
                            text: EmojiHierarchies.hierarchies[index].strong.name, 
                            icon: Icons.arrow_upward
                          ),
                          _IconText(
                            text: EmojiHierarchies.hierarchies[index].weak.name, 
                            icon: Icons.arrow_downward
                          )
                        ]
                      )
                    )
                  );
                } 
              )
            )
          ]
        )
      )
    );
  }
}

class const _IconText({
  required final String text,
  required final IconData icon
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white),
        Text(
          text, 
          style: const TextStyle(
            color: AppColors.white
          )
        )
      ]
    );
  }
}