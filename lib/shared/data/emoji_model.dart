import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';

final class EmojiModel({
  required final String emoji,
  required final EmojiType emojiType,
  required var int attack,
}) {
  factory emptyEmoji() => 
    EmojiModel(emoji: "", emojiType: .neutro, attack: 0);

  void adjustAttack({required int adjustment}) => attack += adjustment;
}