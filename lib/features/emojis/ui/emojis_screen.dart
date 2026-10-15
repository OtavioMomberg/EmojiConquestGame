import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/shared/widgets/header.dart';

class const EmojisScreen({super.key}) extends StatelessWidget {
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
              label: "Emojis", 
              onPressed: () => Navigator.pop(context)
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemCount: EmojisDataset.emojis.length,
                itemBuilder: (context, index) {
                  return Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: AppThemes.stdBorderRadius,
                    ),
                    child: ListTile(
                      contentPadding: AppThemes.containerStdPadding,
                      tileColor: AppColors.grayBluish,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppThemes.stdBorderRadius,
                      ),
                      leading: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: .all(color: AppColors.white)
                        ),
                        child: Center(
                          child: Text(
                            EmojisDataset.emojis[index].emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      title: Text(
                        "Classe: ${EmojisDataset.emojis[index].emojiType.name}\n"
                        "Ataque: ${EmojisDataset.emojis[index].attack}",
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}