import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'package:material_ui/material_ui.dart';

import 'dart:math';

import 'package:drag_and_drop_game/features/game/data/notifiers.dart';
import 'package:drag_and_drop_game/shared/data/game_data.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';

const turns = 6;
const fieldsQuantity = 4;

final class GameService._() {
  static final _instance = GameService._();
  factory instance() => _instance;

  late PlayerModel _player1;
  late PlayerModel _player2;
  late final List<FieldModel> _fields;
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

  void setUpPlayers({required GameData gameData}) {
    _notifiers.turn.value = gameData.playerToStart;

    _player1 = PlayerModel(
      emojis: gameData.player1Emojis,
      playerId: gameData.playerToStart,
    );

    final playerId = (_notifiers.turn.value == .x) ? PlayerId.y : PlayerId.x;

    _player2 = PlayerModel(emojis: gameData.player2Emojis, playerId: playerId);
  }

  void initFields() =>
      _fields = .generate(fieldsQuantity, (field) => FieldModel());

  void changeTurn() =>
      _notifiers.turn.value = (_notifiers.turn.value == .x) ? .y : .x;

  PlayerModel getPlayer() =>
      _notifiers.turn.value == _player1.playerId ? _player1 : _player2;

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
        length = (index + 1);
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
    final maxValue = (_notifiers.turn.value == _player1.playerId)
      ? _player1.emojis.length
      : _player2.emojis.length;

    int emojiIndex = Random().nextInt(maxValue);

    if (_notifiers.turn.value == _player1.playerId) {
      _player1.getEmoji(index: emojiIndex);
      _player1.changeColor(newColor: AppThemes.colorPicker[colorIndex]);
      _player1.checkColorAdjustment();
      return;
    }
    _player2.getEmoji(index: emojiIndex);
    _player2.changeColor(newColor: AppThemes.colorPicker[colorIndex]);
    _player2.checkColorAdjustment();
  }

  void fieldChangeTurn() {
    final player = getPlayer();

    _notifiers.blockSortButton.value = false;
    _notifiers.draggableColor.value = AppColors.gray;
    player.emoji.restoreOriginalAttack();
    changeTurn();
  }

  EmojiModel? completeTurn({required FieldModel field}) {
    _turnCompleted++;

    if (_turnCompleted == 2) {
      _turnCompleted = 0;
      if (!field.hasEmoji()) { return null; }
      return field.increaseTurn() ? field.removeEmoji() : null;
    }
    return null;
  }
}