import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'dart:math';

class DefenseEmoji {
  List<EmojiData> p1Emojis = [];
  List<EmojiData> p2Emojis = [];
  List<EmojiData> emojiSelected;
  List<bool> defenseEmojiInField;
  List<int> defenseEmojiTurns;
  List<EmojiData?> defenseEmojiSelected;
  Map<String, String> defenseEmojiPlayer = {"player": ""};
  int emojiIndex;
  Random rand;

  DefenseEmoji(
    this.p1Emojis, 
    this.p2Emojis,
    this.emojiSelected,
    this.defenseEmojiInField,
    this.defenseEmojiTurns,
    this.defenseEmojiSelected,
    this.defenseEmojiPlayer,
    this.emojiIndex,
    Random random
  ) : rand = random;

  String getEmoji(String playerTurn) {
    int index = rand.nextInt(playerTurn == "X" ? p1Emojis.length : p2Emojis.length);
    emojiIndex = index;

    if (playerTurn == "X") {
      print("AQUI");
      print(p1Emojis);
      return p1Emojis[index].emoji;
    } else {
      print("AQUI");
      print(p2Emojis);
      return p2Emojis[index].emoji;
    }
  }

  void removeDefenseEmoji(int index, [bool? removeAttacker]) {
    print("AQUI");
    print("INDEX: $index");
    print("EMOJI ANTES: $emojiSelected");
    print(removeAttacker);
    if (removeAttacker == false) {
      index == 0 ? p1Emojis.removeAt(emojiIndex) : p2Emojis.removeAt(emojiIndex);
      print("VOLTOU: $p1Emojis");
      print("VOLTOU: $p2Emojis");
      return;
    }
    if (removeAttacker != true) {
      print("TREU");
      index == 0 ? p1Emojis.add(emojiSelected[0]) : p2Emojis.add(emojiSelected[1]);
    }
    defenseEmojiTurns[index] = 0;
    defenseEmojiInField[index] = false;
    print(defenseEmojiSelected);
    for (int i=0; i<defenseEmojiSelected.length; i++) {
      if (defenseEmojiSelected[i] == emojiSelected[index == 0 ? 0 : 1]) {
        defenseEmojiSelected[i] = EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0);
        break;
      }
    }
    print(defenseEmojiSelected);
    print("EMOJI: $emojiSelected");
    emojiSelected[index == 0 ? 0 : 1] = EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0);
    print("VOLTOU: $p1Emojis");
    print("VOLTOU: $p2Emojis");
  }

  String checkDefenseEmojiPlayer() {
    return defenseEmojiPlayer["player"]!;
  }

}