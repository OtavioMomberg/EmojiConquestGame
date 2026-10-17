import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';

class const EmojiBottomSheet({
  required final PlayerModel player, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: .all(.circular(30)),
            gradient: AppThemes.gradient,
          ),
          padding: AppThemes.containerStdPadding,
          child: Column(
            spacing: 10,
            children: <Widget>[
              Text(
                "Emojis de: ${player.playerId.name.toUpperCase()}",
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: .bold,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemCount: player.emojis.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: AppColors.grayBluish.withValues(alpha: .3),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppThemes.stdBorderRadius,
                      ),
                      child: ListTile(
                        onTap: () => Navigator.pop(context, index),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppThemes.stdBorderRadius,
                        ),
                        title: Center(
                          child: Text(
                            player.emojis[index].emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}