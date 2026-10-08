import 'package:drag_and_drop_game/shared/data/emoji_data.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';

class const GameScreenData({
  required final List<EmojiData> player1Emojis,
  required final List<EmojiData> player2Emojis,
  required final PlayerId playerTurn
});
