import 'package:drag_and_drop_game/models/emoji.dart';

class FieldType {
  static List<Map<String, dynamic>> fields = [
    {"field" : "Selva", "buff": EmojiClass.animais, "nerf": EmojiClass.humanos},
    {"field" : "Cidade", "buff": EmojiClass.humanos, "nerf": EmojiClass.animais},
    {"field" : "Espaço", "buff": EmojiClass.poderes, "nerf": EmojiClass.frutas},
    {"field" : "Deserto", "buff": EmojiClass.criaturas, "nerf": EmojiClass.poderes},
    {"field" : "Gelo", "buff": EmojiClass.frutas, "nerf": EmojiClass.criaturas},
    {"field" : "Nuvem", "buff": EmojiClass.neutro, "nerf": EmojiClass.neutro},
    {"field" : "Montanha", "buff": EmojiClass.neutro, "nerf": EmojiClass.neutro},
    {"field" : "Vulcão", "buff": EmojiClass.neutro, "nerf": EmojiClass.neutro},
  ];
}

class Field {
  final int index;
  bool? isConquested = false;
  String? playerConquested;
  bool? containDefenseEmoji = false;
  String? defenseEmojiOwner;

  Field({
    required this.index, 
    this.isConquested, 
    this.playerConquested,
    this.containDefenseEmoji,
    this.defenseEmojiOwner
  });

  String? fieldSelected;

  void setField() {
    fieldSelected = FieldType.fields[index]["field"];
  }

  int checkFieldAdvantage(EmojiClass emojiClass) {
    int buff = FieldType.fields[index]["buff"] == emojiClass ? -4 : 0;
    int nerf = FieldType.fields[index]["nerf"] == emojiClass ? 4 : 0;

    return buff + nerf;
  }
}