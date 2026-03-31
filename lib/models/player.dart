import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'dart:math';

class Player {
  String player;
  String emoji;
  int attack;
  EmojiClass emojiClass;
  Color color;
  
  Player({
    required this.player,
    required this.emoji,
    required this.attack,
    required this.emojiClass,
    required this.color
  });

  Map<String, dynamic> toMap() {
    return {
      "player": player, 
      "emoji": emoji, 
      "attack": attack, 
      "emoji_class": emojiClass,
      "color": color
    };
  }

  static int changeValue() {
    final Random rand = Random();
    int value = rand.nextInt(100) + 1;

    return value > 25 ? -5 : 5;
  }
}
