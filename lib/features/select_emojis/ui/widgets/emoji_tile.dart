import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';
import 'package:material_ui/material_ui.dart';

class const EmojiTile({
  required final SelectEmojiService selectService,
  required final int index,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !selectService.emojiAvaliable[index],
      child: Material(
        elevation: 5,
        color: selectService.getTileColor(index: index),
        shadowColor: AppColors.gray,
        borderRadius: AppThemes.stdBorderRadius,
        child: InkWell(
          borderRadius: AppThemes.stdBorderRadius,
          onTap: () {
            selectService.player.play(audio: .button1);
            selectService.selectEmoji(index: index);
          },
          child: Center(
            child: Text(
              EmojisDataset.emojis[index].emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
