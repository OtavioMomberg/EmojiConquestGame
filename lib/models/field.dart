import 'package:drag_and_drop_game/models/emoji.dart';

enum FieldType { selva, cidade, espaco, deserto, gelo, nuvem, montanha, vulcao }

class const FieldHierarchy({
  required final FieldType field,
  required final EmojiType buff,
  required final EmojiType nerf,
});

class const FieldHierarchies._() {
  static const fields = [
    FieldHierarchy(field: .selva, buff: .animais, nerf: .humanos),
    FieldHierarchy(field: .cidade, buff: .humanos, nerf: .animais),
    FieldHierarchy(field: .espaco, buff: .poderes, nerf: .frutas),
    FieldHierarchy(field: .deserto, buff: .criaturas, nerf: .poderes),
    FieldHierarchy(field: .gelo, buff: .frutas, nerf: .criaturas),
    FieldHierarchy(field: .nuvem, buff: .neutro, nerf: .neutro),
    FieldHierarchy(field: .montanha, buff: .neutro, nerf: .neutro),
    FieldHierarchy(field: .vulcao, buff: .neutro, nerf: .neutro),
  ];
}

class Field({
  required final int index,
  var bool? isConquested = false,
  var bool? containDefenseEmoji = false,
  var String? playerConquested,
  var String? defenseEmojiOwner,
}) {
  String? fieldSelected;

  void setField() {
    fieldSelected = FieldHierarchies.fields[index].field.toString();
  }

  int getAdjustmentFieldDamage(EmojiType emojiClass) {
    final field = FieldHierarchies.fields[index];

    int buff = (field.buff == emojiClass) ? -4 : 0;
    int nerf = (field.nerf == emojiClass) ? 4 : 0;

    return buff + nerf;
  }
}
