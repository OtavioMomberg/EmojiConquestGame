import 'package:drag_and_drop_game/shared/data/emoji_model.dart';

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

class const EmojisDataset._() {
  static const emojis = [
    EmojiModel(emoji: "🤖", emojiType: .criaturas, attack: 15),
    EmojiModel(emoji: "👾", emojiType: .criaturas, attack: 10),
    EmojiModel(emoji: "👽", emojiType: .criaturas, attack: 12),
    EmojiModel(emoji: "👻", emojiType: .criaturas, attack: 8),
    EmojiModel(emoji: "💀", emojiType: .criaturas, attack: 5),
    EmojiModel(emoji: "💩", emojiType: .criaturas, attack: 8),
    EmojiModel(emoji: "🧚‍♀️", emojiType: .poderes, attack: 9),
    EmojiModel(emoji: "🧞‍♂️", emojiType: .poderes, attack: 10),
    EmojiModel(emoji: "🥷", emojiType: .poderes, attack: 10),
    EmojiModel(emoji: "🧑‍🎤", emojiType: .poderes, attack: 12),
    EmojiModel(emoji: "🧛", emojiType: .poderes, attack: 14),
    EmojiModel(emoji: "🧙‍♂️", emojiType: .poderes, attack: 18),
    EmojiModel(emoji: "👨‍🔧", emojiType: .humanos, attack: 11),
    EmojiModel(emoji: "👩‍🚀", emojiType: .humanos, attack: 12),
    EmojiModel(emoji: "🧑‍⚖️", emojiType: .humanos, attack: 8),
    EmojiModel(emoji: "👩‍🔬", emojiType: .humanos, attack: 14),
    EmojiModel(emoji: "👩‍💻", emojiType: .humanos, attack: 13),
    EmojiModel(emoji: "🕵️‍♀️", emojiType: .humanos, attack: 9),
    EmojiModel(emoji: "🦧", emojiType: .animais, attack: 16),
    EmojiModel(emoji: "🦓", emojiType: .animais, attack: 8),
    EmojiModel(emoji: "🦬", emojiType: .animais, attack: 14),
    EmojiModel(emoji: "🦥", emojiType: .animais, attack: 6),
    EmojiModel(emoji: "🦏", emojiType: .animais, attack: 16),
    EmojiModel(emoji: "🦘", emojiType: .animais, attack: 13),
    EmojiModel(emoji: "🍉", emojiType: .frutas, attack: 5),
    EmojiModel(emoji: "🍎", emojiType: .frutas, attack: 11),
    EmojiModel(emoji: "🍊", emojiType: .frutas, attack: 7),
    EmojiModel(emoji: "🍇", emojiType: .frutas, attack: 3),
    EmojiModel(emoji: "🍓", emojiType: .frutas, attack: 7),
    EmojiModel(emoji: "🍐", emojiType: .frutas, attack: 10),
  ];
}
