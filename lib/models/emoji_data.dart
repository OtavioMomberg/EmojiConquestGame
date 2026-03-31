import 'package:drag_and_drop_game/models/emoji.dart';

class EmojiData {
  final String emoji;
  final EmojiClass emojiClass;
  int attack;

  EmojiData({
    required this.emoji,
    required this.emojiClass,
    required this.attack
  });
}