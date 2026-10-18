import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';

const maxTurnsEmojiInField = 3;

final class FieldModel {
  int _lifeX = 100;
  int _lifeY = 100;
  int _turnsEmojiInField = 0;
  bool _isConquested = false;
  PlayerId _whoConquested = .neutro;
  PlayerId _emojiOwner = .neutro;
  EmojiModel _emoji = EmojiModel.emptyEmoji();
  final _emojiDisplay = ValueNotifier<String>("");

  int get lifeX => (_lifeX < 0) ? 0 : _lifeX;
  int get lifeY => (_lifeY < 0) ? 0 : _lifeY;
  int get turnsEmojiInField => _turnsEmojiInField;
  bool get isConquested => _isConquested;
  PlayerId get whoConquested => _whoConquested;
  EmojiModel get emoji => _emoji;
  PlayerId get emojiOwner => _emojiOwner;
  ValueNotifier<String> get emojiDisplay => _emojiDisplay;

  void receiveDamage({required PlayerModel player}) {
    player.playerId == .x
      ? _lifeX -= player.emoji.attack
      : _lifeY -= player.emoji.attack;
    
    _conquestField(player: player);
  }

  void _conquestField({required PlayerModel player}) {
    if (_lifeX > 0 && _lifeY > 0) { return; }

    _isConquested = true;
    _whoConquested = player.playerId;
    player.addFieldConquested();

    if (hasEmoji()) {
      player..addEmoji(emoji: removeEmoji())
      ..changeEmojiInField();
    }
  }

  void placeEmoji({required EmojiModel emoji, required PlayerId player}) {
    _emoji = emoji;
    _emojiOwner = player;
    _emojiDisplay.value = emoji.emoji;
  }

  EmojiModel removeEmoji() {
    final playerEmoji = _emoji;
    _emoji = EmojiModel.emptyEmoji();
    _emojiOwner = .neutro;
    _turnsEmojiInField = 0;
    _emojiDisplay.value = "";

    return playerEmoji;
  }

  bool hasEmoji() => (_emoji.emojiType == .neutro) ? false : true;

  bool increaseTurn() {
    _turnsEmojiInField++;
    if (_turnsEmojiInField == maxTurnsEmojiInField) {
      _turnsEmojiInField = 0;
      return true;
    }
    return false;
  }
}