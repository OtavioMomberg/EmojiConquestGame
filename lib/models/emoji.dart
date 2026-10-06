import 'package:drag_and_drop_game/models/emoji_data.dart';

enum EmojiType { criaturas, poderes, humanos, animais, frutas, neutro }

class const EmojiHierarchy({
  required final EmojiType type,
  required final EmojiType strong,
  required final EmojiType weak,
});

class const EmojiHierarchies._() {
  static const hierarchies = [
    EmojiHierarchy(type: .criaturas, strong: .poderes, weak: .frutas),
    EmojiHierarchy(type: .poderes, strong: .humanos, weak: .criaturas),
    EmojiHierarchy(type: .humanos, strong: .animais, weak: .poderes),
    EmojiHierarchy(type: .animais, strong: .frutas, weak: .humanos),
    EmojiHierarchy(type: .frutas, strong: .criaturas, weak: .animais),
  ];
}

class const EmojisInfo._() {
  static const emojis = [
    EmojiData(emoji: "🤖", emojiType: .criaturas, attack: 15),
    EmojiData(emoji: "👾", emojiType: .criaturas, attack: 10),
    EmojiData(emoji: "👽", emojiType: .criaturas, attack: 12),
    EmojiData(emoji: "👻", emojiType: .criaturas, attack: 8),
    EmojiData(emoji: "💀", emojiType: .criaturas, attack: 5),
    EmojiData(emoji: "💩", emojiType: .criaturas, attack: 8),
    EmojiData(emoji: "🧚‍♀️", emojiType: .poderes, attack: 9),
    EmojiData(emoji: "🧞‍♂️", emojiType: .poderes, attack: 10),
    EmojiData(emoji: "🥷", emojiType: .poderes, attack: 10),
    EmojiData(emoji: "🧑‍🎤", emojiType: .poderes, attack: 12),
    EmojiData(emoji: "🧛", emojiType: .poderes, attack: 14),
    EmojiData(emoji: "🧙‍♂️", emojiType: .poderes, attack: 18),
    EmojiData(emoji: "👨‍🔧", emojiType: .humanos, attack: 11),
    EmojiData(emoji: "👩‍🚀", emojiType: .humanos, attack: 12),
    EmojiData(emoji: "🧑‍⚖️", emojiType: .humanos, attack: 8),
    EmojiData(emoji: "👩‍🔬", emojiType: .humanos, attack: 14),
    EmojiData(emoji: "👩‍💻", emojiType: .humanos, attack: 13),
    EmojiData(emoji: "🕵️‍♀️", emojiType: .humanos, attack: 9),
    EmojiData(emoji: "🦧", emojiType: .animais, attack: 16),
    EmojiData(emoji: "🦓", emojiType: .animais, attack: 8),
    EmojiData(emoji: "🦬", emojiType: .animais, attack: 14),
    EmojiData(emoji: "🦥", emojiType: .animais, attack: 6),
    EmojiData(emoji: "🦏", emojiType: .animais, attack: 16),
    EmojiData(emoji: "🦘", emojiType: .animais, attack: 13),
    EmojiData(emoji: "🍉", emojiType: .frutas, attack: 5),
    EmojiData(emoji: "🍎", emojiType: .frutas, attack: 11),
    EmojiData(emoji: "🍊", emojiType: .frutas, attack: 7),
    EmojiData(emoji: "🍇", emojiType: .frutas, attack: 3),
    EmojiData(emoji: "🍓", emojiType: .frutas, attack: 7),
    EmojiData(emoji: "🍐", emojiType: .frutas, attack: 10),
  ];

  static int getAdjustmentEmojiDamage({
    required EmojiType defenseEmoji,
    required EmojiType attackerEmoji,
  }) {
    final findHierarchy = EmojiHierarchies.hierarchies.firstWhere(
      (h) => h.type == defenseEmoji,
    );

    int buff = (findHierarchy.strong == attackerEmoji) ? 3 : 0;

    int nerf = (findHierarchy.weak == attackerEmoji) ? -3 : 0;

    return buff + nerf;
  }
}
