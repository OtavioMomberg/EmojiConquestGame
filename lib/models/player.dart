import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'dart:math';

class Player({
  required final String player,
  required final String emoji,
  required final int attack,
  required final EmojiType emojiType,
  required final Color color,
}) {
  Map<String, dynamic> toMap() {
    return {
      "player": player,
      "emoji": emoji,
      "attack": attack,
      "emoji_class": emojiType,
      "color": color,
    };
  }

  static int changeValue() {
    final Random random = Random();
    int value = random.nextInt(100) + 1;

    return value > 25 ? -2 : 2;
  }
}
