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

  int get lifeX => _lifeX;
  int get lifeY => _lifeY;
  int get turnsEmojiInField => _turnsEmojiInField;
  bool get isConquested => _isConquested;
  PlayerId get whoConquested => _whoConquested;
  EmojiModel get emoji => _emoji;
  PlayerId get emojiOwner => _emojiOwner;

  void receiveDamage({required int attack, required PlayerId player}) {
    player == .x
      ? _lifeX -= (attack <= _lifeX) ? attack : _lifeX
      : _lifeY -= (attack <= _lifeY) ? attack : _lifeY;
    
    _checkFieldIsConquested();
  }

  void _checkFieldIsConquested() {
    if (_lifeX == 0) {
      _conquestField(player: .x);
      return;
    }
    if (_lifeY == 0) { _conquestField(player: .y); }
  }

  void _conquestField({required PlayerId player}) {
    _isConquested = true;
    _whoConquested = player;
  }

  void placeEmoji({required EmojiModel emoji, required PlayerId player}) {
    _emoji = emoji;
    _emojiOwner = player;
  }

  EmojiModel removeEmoji() {
    final returnPlayerEmoji = _emoji;
    _emoji = EmojiModel.emptyEmoji();
    _emojiOwner = .neutro;
    _turnsEmojiInField = 0;

    return returnPlayerEmoji;
  }

  bool hasEmoji() => (_emoji.emojiType == .neutro) ? false : true;

  bool increaseTurn() {
    if (_turnsEmojiInField == maxTurnsEmojiInField) {
      _turnsEmojiInField = 0;
      return true;
    }
    _turnsEmojiInField++;
    return false;
  }
}