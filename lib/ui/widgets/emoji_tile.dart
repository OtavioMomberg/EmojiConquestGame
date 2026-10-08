import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/services/select_emoji_service.dart';
import 'package:material_ui/material_ui.dart';

class const EmojiTile({
  required final SelectEmojiService selectService,
  required final int index,
  super.key,
}) extends StatefulWidget {
  @override
  State<EmojiTile> createState() => _EmojiTileState();
}

class _EmojiTileState extends State<EmojiTile> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.selectService.emojiAvaliable[widget.index],
      child: Material(
        elevation: 5,
        color: widget.selectService.getTileColor(index: widget.index),
        type: .card,
        borderRadius: AppThemes.stdBorderRadius,
        child: InkWell(
          borderRadius: AppThemes.stdBorderRadius,
          onTap: () {
            widget.selectService.player.play(audio: .button1);
            widget.selectService.selectEmoji(index: widget.index);
            setState(() {
              widget.selectService.emojiAvaliable[widget.index] =
                !widget.selectService.emojiAvaliable[widget.index];
            });
          },
          child: Center(
            child: Text(
              EmojisInfo.emojis[widget.index].emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}