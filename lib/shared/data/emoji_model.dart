import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';

const extraClassDamage = 1;

final class EmojiModel({
  required final String emoji,
  required final EmojiType emojiType,
  required var int attack
}) {
  final _originalAttack = attack;

  factory emptyEmoji() => 
    EmojiModel(emoji: "", emojiType: .neutro, attack: 0);

  void adjustColorAttack({required int adjustment}) => 
    attack += adjustment;

  void adjustClassAttack({required EmojiType defenseEmoji}) {
    final hierarchy = EmojiHierarchies.hierarchies.
      firstWhere((h) => h.type == emojiType);

    if (hierarchy.strong == defenseEmoji) {
      attack += extraClassDamage;
      return;
    }
    if (hierarchy.weak == defenseEmoji) {
      attack -= extraClassDamage;
    }
  }

  int displayAdjustedAttack({required EmojiType defenseEmoji}) {
    final hierarchy = EmojiHierarchies.hierarchies.
      firstWhere((h) => h.type == emojiType);

    if (hierarchy.strong == defenseEmoji) {
      return attack + extraClassDamage;
    }
    if (hierarchy.weak == defenseEmoji) {
      return attack - extraClassDamage;
    }
    return attack;
  }

  void restoreOriginalAttack() => attack = _originalAttack;
}