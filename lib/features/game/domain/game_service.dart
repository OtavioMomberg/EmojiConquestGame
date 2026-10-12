import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:drag_and_drop_game/shared/data/game_data.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';

const turns = 6;
const fieldsQuantity = 4;

class GameService._() {
  static final _instance = GameService._();
  factory instance() => _instance;

  late final List<FieldModel> _fields;
  late PlayerModel _player1;
  late PlayerModel _player2;

  final audioPlayer = AudioHelper.instance();
  final _blockSortButton = ValueNotifier<bool>(false);
  final _selectedColor = ValueNotifier<List<bool>>([true, false, false, false]);
  final _draggableColor = ValueNotifier<Color>(AppColors.gray);

  PlayerId _currentTurn = PlayerId.neutro;

  PlayerModel get player1 => _player1;
  PlayerModel get player2 => _player2;
  ValueNotifier<bool> get blockSortButton => _blockSortButton;
  ValueNotifier<List<bool>> get selectedColor => _selectedColor;
  ValueNotifier<Color> get draggableColor => _draggableColor;
  List<FieldModel> get fields => _fields;
  PlayerId get currentTurn => _currentTurn;

  void dispose() {
    _blockSortButton.dispose();
    _selectedColor.dispose();
    _draggableColor.dispose();
  }

  void setUpPlayers({required GameData gameData}) {
    _currentTurn = gameData.playerToStart;

    _player1 = PlayerModel(
      emojis: gameData.player1Emojis,
      playerId: gameData.playerToStart,
    );

    final playerId = (_currentTurn == .x) 
      ? PlayerId.y : PlayerId.x; 

    _player2 = PlayerModel(
      emojis: gameData.player2Emojis, 
      playerId: playerId
    );
  }

  void initFields() => 
    _fields = List.generate(fieldsQuantity, (field) => FieldModel());

  void changeTurn() =>
    _currentTurn = (_currentTurn == .x) ? .y : .x;
  
  Future<void> selectColor() async {
    _blockSortButton.value = true;
    _draggableColor.value = AppColors.gray;

    int length = _selectedColor.value.length;
    int index = Random().nextInt(length);
    int counter = 0;
    bool isLastIteration = false;

    while (counter <= length) {
      if (counter == length) {
        isLastIteration = true;
        length = (index + 1);
      }

      for (var i = 0; i < length; i++) {
        _selectedColor.value = [false, false, false, false];
        _selectedColor.value[i] = true;

        if (isLastIteration && i == index) {
          audioPlayer.play(audio: .general);
          _blockSortButton.value = false;
          _draggableColor.value = AppThemes.colorPicker[i];
          sortEmojiToPlayer();
        }

        await Future.delayed(const Duration(milliseconds: 200));
      }
      counter++;
    }
  }

  void sortEmojiToPlayer() {
    final maxValue = (_currentTurn == _player1.playerId) 
      ? _player1.emojis.length
      : _player2.emojis.length;

    int emojiIndex = Random().nextInt(maxValue);

    if (_currentTurn == _player1.playerId) {
      _player1.getCurrentEmoji(index: emojiIndex);
      return;
    }
    _player2.getCurrentEmoji(index: emojiIndex);
  }
}