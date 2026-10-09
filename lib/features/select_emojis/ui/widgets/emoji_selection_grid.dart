import 'package:drag_and_drop_game/shared/data/emoji.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';
import 'package:drag_and_drop_game/features/select_emojis/ui/widgets/emoji_tile.dart';
import 'package:material_ui/material_ui.dart';

class const EmojiSelectionGrid({
  required final SelectEmojiService selectService,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3
      ),
      itemCount: EmojisInfo.emojis.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const .only(right: 5, left: 5, bottom: 10),
          child: EmojiTile(
            selectService: selectService, 
            index: index
          )
        );
      }
    );
  }
}