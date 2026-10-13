import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/colors_correction_damage.dart';
import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';

final class PlayerModel({
  required var List<EmojiModel> emojis,
  required final PlayerId playerId,
}) {
  int _fieldsConquested = 0;
  EmojiModel _emoji = EmojiModel.emptyEmoji();
  Color _color = Colors.transparent;

  int get fieldsConquested => _fieldsConquested;
  EmojiModel get emoji => _emoji;
  Color get color => _color;

  void getCurrentEmoji({required int index}) => _emoji = emojis[index];

  void removeEmoji({required String emoji}) =>
      emojis.removeWhere((e) => e.emoji == emoji);

  void addEmoji({required EmojiModel emoji}) => emojis.add(emoji);

  void changeColor({required Color newColor}) {
    _color = newColor;
    _checkColorAdjustment();
  }

  void _checkColorAdjustment() {
    final adjustment = ColorsCorrectionDamage.getCorrection(
      color: _color);
      
    _emoji.adjustColorAttack(adjustment: adjustment);
  }

  void addFieldConquested() => _fieldsConquested++;
}