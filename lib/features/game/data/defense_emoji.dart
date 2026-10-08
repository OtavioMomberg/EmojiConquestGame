import 'package:drag_and_drop_game/shared/data/emoji_data.dart';
import 'dart:math';

class DefenseEmoji({
  required final List<EmojiData> p1Emojis,
  required final List<EmojiData> p2Emojis,
  required final List<EmojiData> emojiSelected,
  required final List<bool> defenseEmojiInField,
  required final List<int> defenseEmojiTurns,
  required final List<EmojiData?> defenseEmojiSelected,
  required final Map<String, String> defenseEmojiPlayer,
  required var int emojiIndex,
}) {
  final _random = Random();

  String getEmoji({required String playerTurn}) {
    int index = _random.nextInt(
      playerTurn == "X" ? p1Emojis.length : p2Emojis.length,
    );

    emojiIndex = index;

    if (playerTurn == "X") {
      return p1Emojis[index].emoji;
    } else {
      return p2Emojis[index].emoji;
    }
  }

  void removeDefenseEmoji({required int index, bool? removeAttacker}) {
    if (removeAttacker == false) {
      index == 0
        ? p1Emojis.removeAt(emojiIndex)
        : p2Emojis.removeAt(emojiIndex);
      return;
    }
    if (removeAttacker != true) {
      index == 0
        ? p1Emojis.add(emojiSelected[0])
        : p2Emojis.add(emojiSelected[1]);
    }

    defenseEmojiTurns[index] = 0;
    defenseEmojiInField[index] = false;

    for (int i = 0; i < defenseEmojiSelected.length; i++) {
      if (defenseEmojiSelected[i] == emojiSelected[index == 0 ? 0 : 1]) {
        defenseEmojiSelected[i] = EmojiData(
          emoji: "",
          emojiType: .neutro,
          attack: 0,
        );
        break;
      }
    }
    emojiSelected[index == 0 ? 0 : 1] = EmojiData(
      emoji: "",
      emojiType: .neutro,
      attack: 0,
    );
  }

  String checkDefenseEmojiPlayer() {
    return defenseEmojiPlayer["player"]!;
  }
}
