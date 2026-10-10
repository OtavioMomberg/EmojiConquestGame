import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';

class const GameInitialData({
  required final List<EmojiModel> player1Emojis,
  required final List<EmojiModel> player2Emojis,
  required final PlayerId playerTurn
});
