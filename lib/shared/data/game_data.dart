import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'player_id.dart';

final class const GameData({
  required final List<EmojiModel> player1Emojis,
  required final List<EmojiModel> player2Emojis,
  required final PlayerId playerToStart,
});
