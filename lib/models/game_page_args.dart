import 'package:drag_and_drop_game/models/emoji_data.dart';

class GamePageArgs {
  List<EmojiData> player1Emojis;
  List<EmojiData> player2Emojis;

  GamePageArgs(this.player1Emojis, this.player2Emojis);
}