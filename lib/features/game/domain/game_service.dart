import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:drag_and_drop_game/shared/data/game_data.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/features/game/data/notifiers.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';

const fieldsQuantity = 4;

typedef Result = void Function({required PlayerId winner});

final class GameService._() {
  static final _instance = GameService._();
  factory instance() => _instance;

  PlayerModel _player1 = PlayerModel.emptyPlayer();
  PlayerModel _player2 = PlayerModel.emptyPlayer();
  Result result = ({required winner}) {};
  final List<FieldModel> _fields = [];
  final audioPlayer = AudioHelper.instance();
  final _notifiers = Notifiers();
  int _turnCompleted = 0;

  PlayerModel get player1 => _player1;
  PlayerModel get player2 => _player2;
  List<FieldModel> get fields => _fields;
  ValueNotifier<PlayerId> get turn => _notifiers.turn;
  ValueNotifier<Color> get draggableColor => _notifiers.draggableColor;
  ValueNotifier<bool> get blockSortButton => _notifiers.blockSortButton;
  ValueNotifier<List<bool>> get selectedColor => _notifiers.selectedColor;

  void disposeNotifiers() => _notifiers.dispose();

  void getResultFunction({required Result resultF}) => result = resultF;

  void setUpPlayers({required GameData gameData}) {
    _notifiers.turn.value = gameData.playerToStart;

    _player1 = PlayerModel(
      emojis: gameData.player1Emojis,
      playerId: gameData.playerToStart,
    );

    final playerId = (_notifiers.turn.value == .x) ? PlayerId.y : PlayerId.x;

    _player2 = PlayerModel(
      emojis: gameData.player2Emojis, 
      playerId: playerId
    );
  }

  void initFields() {
    _fields.clear();
    _fields.addAll(.generate(fieldsQuantity, (_) => FieldModel()));
  }

  void _changeTurn() =>
    _notifiers.turn.value = (_notifiers.turn.value == .x) ? .y : .x;

  PlayerModel getCurrentPlayer() =>
    _notifiers.turn.value == _player1.playerId ? _player1 : _player2;

  PlayerModel getPlayer({required PlayerId player, bool invert = false}) {
    if (invert) {
      return player == _player1.playerId ? _player2 : _player1;
    }
    return player == _player1.playerId ? _player1 : _player2;
  }
    

  String turnToStr() => (_notifiers.turn.value == .x) ? "X" : "Y";

  Future<void> sortEmojiColor() async {
    _notifiers.blockSortButton.value = true;
    _notifiers.draggableColor.value = AppColors.gray;

    int length = _notifiers.selectedColor.value.length;
    int index = Random().nextInt(length);
    int counter = 0;
    bool isLastIteration = false;

    while (counter <= length) {
      if (counter == length) {
        isLastIteration = true;
        length = index + 1;
      }
      for (var i = 0; i < length; i++) {
        _notifiers.selectedColor.value = [false, false, false, false];
        _notifiers.selectedColor.value[i] = true;

        if (isLastIteration && i == index) {
          audioPlayer.play(audio: .general);
          _notifiers.draggableColor.value = AppThemes.colorPicker[i];
          _sortEmojiToPlayer(colorIndex: index);
        }
        await Future.delayed(const Duration(milliseconds: 200));
      }
      counter++;
    }
  }

  void _sortEmojiToPlayer({required int colorIndex}) {
    final player = getCurrentPlayer();
    final maxValue = player.emojis.length;

    int emojiIndex = Random().nextInt(maxValue);

    player..getEmoji(index: emojiIndex)
      ..changeColor(newColor: AppThemes.colorPicker[colorIndex])
      ..checkColorAdjustment();
  }

  void attackWitoutEmoji({
    required PlayerModel player,
    required FieldModel field,
  }) => field.receiveDamage(player: player);

  void attackWithEmoji({
    required PlayerModel player,
    required FieldModel field,
  }) {
    player.emoji.adjustClassAttack(defenseEmoji: field.emoji.emojiType);

    if (player.emoji.attack == field.emoji.attack) { return; }

    if (player.emoji.attack > field.emoji.attack) {
      final _ = field.removeEmoji();
      final defensePlayer = getPlayer(player: player.playerId, invert: true);
      defensePlayer.changeEmojiInField();
      return;
    }
    player.removeEmoji(emoji: player.emoji);
  }

  void changePlayerInTurn() {
    final player = getCurrentPlayer();
    _checkResult(player: player);

    _notifiers.blockSortButton.value = false;
    _notifiers.draggableColor.value = AppColors.gray;
    player.emoji.restoreOriginalAttack();
    _changeTurn();
  }

  void _checkResult({required PlayerModel player}) {
    if (_player1.fieldsConquested == _player2.fieldsConquested) {
      if (_player1.fieldsConquested != fieldsQuantity-2) { return; }

      if (_player1.emojis.length == _player1.emojis.length) {
        result(winner: .neutro);
        return;
      }
      if (_player1.emojis.length > _player1.emojis.length) {
        result(winner: _player1.playerId);
        return;
      }
      result(winner: _player2.playerId);
      return;
    }

    if (player.fieldsConquested == fieldsQuantity-1) {
      result(winner: player.playerId);
    }
  }

  bool validadePlayerBeforeSelectEmoji({required FieldModel field}) {
    if (field.isConquested) { return false; }
    if (field.hasEmoji()) { return false; }
    if (getCurrentPlayer().emojis.length <= 1) { return false; }
    if (getCurrentPlayer().hasEmojiInField) { return false; }
    if (blockSortButton.value) { return false; }
    return true;
  }

  void completeTurn() {
    _turnCompleted++;
    if (_turnCompleted < 2) { return; }
    _turnCompleted = 0;

    for (var field in _fields) {
      if (field.hasEmoji()) {
        if (!field.increaseTurn()) { continue; }
        final player = getPlayer(player: field.emojiOwner);
        final emoji = field.removeEmoji();
        player..addEmoji(emoji: emoji)
          ..changeEmojiInField();
      }
    }
  }
}