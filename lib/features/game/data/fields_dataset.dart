import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';

enum FieldType { selva, cidade, espaco, deserto, gelo, nuvem, montanha, vulcao }

final class const FieldHierarchy({
  required final FieldType field,
  final EmojiType buff = .neutro,
  final EmojiType nerf = .neutro
});

// strong +2 attack
// weak -2 attack
// if emoji is attacking both buff or nerf are applyied
// if emoji is defending neither buff nor nerf are applyed
final class const FieldHierarchies._() {
  static const fields = [
    FieldHierarchy(field: .selva, buff: .animais, nerf: .humanos),
    FieldHierarchy(field: .cidade, buff: .humanos, nerf: .animais),
    FieldHierarchy(field: .espaco, buff: .poderes, nerf: .frutas),
    FieldHierarchy(field: .deserto, buff: .criaturas, nerf: .poderes),
    FieldHierarchy(field: .gelo, buff: .frutas, nerf: .criaturas),
    FieldHierarchy(field: .nuvem),
    FieldHierarchy(field: .montanha),
    FieldHierarchy(field: .vulcao),
  ];
}