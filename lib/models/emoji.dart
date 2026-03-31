import 'package:drag_and_drop_game/models/emoji_data.dart';

enum EmojiClass {
  criaturas,
  poderes,
  humanos,
  animais,
  frutas,
  neutro,
}

class EmojiCheckClass {
  static List<Map<String, dynamic>> classes = [
    {"class" : EmojiClass.criaturas, "strong": EmojiClass.poderes, "weak": EmojiClass.frutas},
    {"class" : EmojiClass.poderes, "strong": EmojiClass.humanos, "weak": EmojiClass.criaturas},
    {"class" : EmojiClass.humanos, "strong": EmojiClass.animais, "weak": EmojiClass.poderes},
    {"class" : EmojiClass.animais, "strong": EmojiClass.frutas, "weak": EmojiClass.humanos},
    {"class" : EmojiClass.frutas, "strong": EmojiClass.criaturas, "weak": EmojiClass.animais}
  ];
}

class Emoji {
  static List<EmojiData> emojiStatsList = [
    EmojiData(emoji: "🤖", emojiClass: EmojiClass.criaturas, attack: 15),
    EmojiData(emoji: "👾", emojiClass: EmojiClass.criaturas, attack: 10),
    EmojiData(emoji: "👽", emojiClass: EmojiClass.criaturas, attack: 12),
    EmojiData(emoji: "👻", emojiClass: EmojiClass.criaturas, attack: 8),
    EmojiData(emoji: "💀", emojiClass: EmojiClass.criaturas, attack: 5),
    EmojiData(emoji: "💩", emojiClass: EmojiClass.criaturas, attack: 8),
    EmojiData(emoji: "🧚‍♀️", emojiClass: EmojiClass.poderes, attack: 9),
    EmojiData(emoji: "🧞‍♂️", emojiClass: EmojiClass.poderes, attack: 10),
    EmojiData(emoji: "🥷", emojiClass: EmojiClass.poderes, attack: 10),
    EmojiData(emoji: "🧑‍🎤", emojiClass: EmojiClass.poderes, attack: 12),
    EmojiData(emoji: "🧛", emojiClass: EmojiClass.poderes, attack: 14),
    EmojiData(emoji: "🧙‍♂️", emojiClass: EmojiClass.poderes, attack: 18),
    EmojiData(emoji: "👨‍🔧", emojiClass: EmojiClass.humanos, attack: 11),
    EmojiData(emoji: "👩‍🚀", emojiClass: EmojiClass.humanos, attack: 12),
    EmojiData(emoji: "🧑‍⚖️", emojiClass: EmojiClass.humanos, attack: 8),
    EmojiData(emoji: "👩‍🔬", emojiClass: EmojiClass.humanos, attack: 14),
    EmojiData(emoji: "👩‍💻", emojiClass: EmojiClass.humanos, attack: 13),
    EmojiData(emoji: "🕵️‍♀️", emojiClass: EmojiClass.humanos, attack: 9),
    EmojiData(emoji: "🦧", emojiClass: EmojiClass.animais, attack: 16),
    EmojiData(emoji: "🦓", emojiClass: EmojiClass.animais, attack: 8),
    EmojiData(emoji: "🦬", emojiClass: EmojiClass.animais, attack: 14),
    EmojiData(emoji: "🦥", emojiClass: EmojiClass.animais, attack: 6),
    EmojiData(emoji: "🦏", emojiClass: EmojiClass.animais, attack: 16),
    EmojiData(emoji: "🦘", emojiClass: EmojiClass.animais, attack: 13),
    EmojiData(emoji: "🍉", emojiClass: EmojiClass.frutas, attack: 5),
    EmojiData(emoji: "🍎", emojiClass: EmojiClass.frutas, attack: 11),
    EmojiData(emoji: "🍊", emojiClass: EmojiClass.frutas, attack: 7),
    EmojiData(emoji: "🍇", emojiClass: EmojiClass.frutas, attack: 3),
    EmojiData(emoji: "🍓", emojiClass: EmojiClass.frutas, attack: 7),
    EmojiData(emoji: "🍐", emojiClass: EmojiClass.frutas, attack: 10),
  ];

  static int checkEmojiClassAdvantage(EmojiClass defenseEmoji, EmojiClass attackerEmoji) {
    Map<EmojiClass, int> map = {
      EmojiClass.criaturas : 0,
      EmojiClass.poderes : 1,
      EmojiClass.humanos : 2,
      EmojiClass.animais : 3,
      EmojiClass.frutas : 4
    };

    int buff = EmojiCheckClass.classes[map[defenseEmoji]!]["strong"] == attackerEmoji ? 3 : 0;
    int nerf = EmojiCheckClass.classes[map[defenseEmoji]!]["weak"] == attackerEmoji ? -3 : 0;

    return buff + nerf;
  }
}