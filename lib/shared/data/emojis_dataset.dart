import 'package:drag_and_drop_game/shared/data/emoji_model.dart';

enum EmojiType { criaturas, poderes, humanos, animais, frutas, neutro }

final class const EmojiHierarchy({
  required final EmojiType type,
  required final EmojiType strong,
  required final EmojiType weak,
});

final class const EmojiHierarchies._() {
  static const hierarchies = [
    EmojiHierarchy(type: .criaturas, strong: .poderes, weak: .frutas),
    EmojiHierarchy(type: .poderes, strong: .humanos, weak: .criaturas),
    EmojiHierarchy(type: .humanos, strong: .animais, weak: .poderes),
    EmojiHierarchy(type: .animais, strong: .frutas, weak: .humanos),
    EmojiHierarchy(type: .frutas, strong: .criaturas, weak: .animais),
  ];
}

final class const EmojisDataset._() {
  static final emojis = [
    EmojiModel(emoji: "🤖", emojiType: .criaturas, attack: 15),
    EmojiModel(emoji: "👾", emojiType: .criaturas, attack: 10),
    EmojiModel(emoji: "👽", emojiType: .criaturas, attack: 12),
    EmojiModel(emoji: "👻", emojiType: .criaturas, attack: 08),
    EmojiModel(emoji: "💀", emojiType: .criaturas, attack: 05),
    EmojiModel(emoji: "💩", emojiType: .criaturas, attack: 08),
    EmojiModel(emoji: "🧚‍♀️", emojiType: .poderes, attack: 09),
    EmojiModel(emoji: "🧞‍♂️", emojiType: .poderes, attack: 10),
    EmojiModel(emoji: "🥷", emojiType: .poderes, attack: 10),
    EmojiModel(emoji: "🧑‍🎤", emojiType: .poderes, attack: 12),
    EmojiModel(emoji: "🧛", emojiType: .poderes, attack: 14),
    EmojiModel(emoji: "🧙‍♂️", emojiType: .poderes, attack: 18),
    EmojiModel(emoji: "👨‍🔧", emojiType: .humanos, attack: 11),
    EmojiModel(emoji: "👩‍🚀", emojiType: .humanos, attack: 12),
    EmojiModel(emoji: "🧑‍⚖️", emojiType: .humanos, attack: 08),
    EmojiModel(emoji: "👩‍🔬", emojiType: .humanos, attack: 14),
    EmojiModel(emoji: "👩‍💻", emojiType: .humanos, attack: 13),
    EmojiModel(emoji: "🕵️‍♀️", emojiType: .humanos, attack: 09),
    EmojiModel(emoji: "🦧", emojiType: .animais, attack: 16),
    EmojiModel(emoji: "🦓", emojiType: .animais, attack: 08),
    EmojiModel(emoji: "🦬", emojiType: .animais, attack: 14),
    EmojiModel(emoji: "🦥", emojiType: .animais, attack: 06),
    EmojiModel(emoji: "🦏", emojiType: .animais, attack: 16),
    EmojiModel(emoji: "🦘", emojiType: .animais, attack: 13),
    EmojiModel(emoji: "🍉", emojiType: .frutas, attack: 05),
    EmojiModel(emoji: "🍎", emojiType: .frutas, attack: 11),
    EmojiModel(emoji: "🍊", emojiType: .frutas, attack: 07),
    EmojiModel(emoji: "🍇", emojiType: .frutas, attack: 03),
    EmojiModel(emoji: "🍓", emojiType: .frutas, attack: 07),
    EmojiModel(emoji: "🍐", emojiType: .frutas, attack: 10),
  ];
}
