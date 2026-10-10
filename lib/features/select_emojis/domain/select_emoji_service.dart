import 'package:material_ui/material_ui.dart';

import 'dart:math';

import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';
import 'package:drag_and_drop_game/shared/data/emoji_model.dart';
import 'package:drag_and_drop_game/features/select_emojis/data/players_emojis.dart';

const playerOne = 1;
const playerTwo = 2;
const _sortRange = 4;

enum PlayerId { x, y }

typedef DialogFunction = Future<void> Function({required int player});

class SelectEmojiService {
  late final VoidCallback setState;
  late final DialogFunction dialog;

  final player = AudioHelper.instance();
  final _player1Emojis = PlayerEmojis();
  final _player2Emojis = PlayerEmojis();
  final _emojiAvaliable = List.generate(
    EmojisDataset.emojis.length,
    (index) => true,
  );

  PlayerId _sortPlayerToStart = .x;
  PlayerId _displayPlayer = .x;
  int _contEmoji = 0;

  int get contEmoji => _contEmoji;
  PlayerId get sortPlayerToStart => _sortPlayerToStart;
  String get displayPlayer => _displayPlayer == .x ? "X" : "Y";

  List<bool> get emojiAvaliable => _emojiAvaliable;
  List<EmojiModel> get player1Emojis => _player1Emojis.emojis;
  List<EmojiModel> get player2Emojis => _player2Emojis.emojis;

  void getFunctions({
    required VoidCallback getSetState,
    required DialogFunction getDialog,
  }) {
    setState = getSetState;
    dialog = getDialog;
  }

  void sortPlayer() {
    int value = Random().nextInt(_sortRange) + 1;
    _sortPlayerToStart = (value % 2 == 0) ? .x : .y;
    _displayPlayer = sortPlayerToStart;
    _switchPalyers();
  }

  void _switchPalyers() {
    if (_sortPlayerToStart == .x) {
      return;
    }

    final aux = player1Emojis;

    _player1Emojis.emojis.clear();
    _player1Emojis.emojis.addAll(player2Emojis);

    _player2Emojis.emojis.clear();
    _player2Emojis.emojis.addAll(aux);
  }

  void selectEmoji({required int index}) async {
    _contEmoji++;
    _emojiAvaliable[index] = !_emojiAvaliable[index];

    PlayerEmojis player = _player1Emojis;
    int playerNumber = 0;

    if (player1Emojis.length < 4) {
      player = _player1Emojis;
      playerNumber = playerOne;
    } else {
      player = _player2Emojis;
      playerNumber = playerTwo;
    }

    _addEmojiToPlayerList(
      index: index,
      playerNumber: playerNumber,
      player: player,
    );
  }

  Future<void> _addEmojiToPlayerList({
    required int index,
    required int playerNumber,
    required PlayerEmojis player,
  }) async {
    player.emojis.add(EmojisDataset.emojis[index]);
    player.indexes.add(index);
    setState();
    if (player.emojis.length == 4) {
      await dialog(player: playerNumber);
      setState();
    }
  }

  void dialogResponseAction({required bool response}) {
    _contEmoji = 0;
    switch (response) {
      case true:
        _resetEmojisTile(response: true);
        _clearEmojisLists();
        break;
      case false:
        _resetEmojisTile(response: false);
        _switchDisplay();
        break;
    }
  }

  void _resetEmojisTile({required bool response}) {
    final index = (_player2Emojis.indexes.isEmpty)
        ? _player1Emojis.indexes
        : _player2Emojis.indexes;

    for (int i = 0; i < index.length; i++) {
      _emojiAvaliable[index[i]] = response;
    }
  }

  void _clearEmojisLists() {
    if (_player2Emojis.indexes.isEmpty) {
      _player1Emojis.emojis.clear();
      _player1Emojis.indexes.clear();
      return;
    }
    _player2Emojis.emojis.clear();
    _player2Emojis.indexes.clear();
  }

  void _switchDisplay() {
    _displayPlayer = (_displayPlayer == .x) ? .y : .x;
  }

  Color getTileColor({required int index}) {
    if (emojiAvaliable[index]) {
      return AppThemes.grayBluish;
    }
    if (_player1Emojis.indexes.contains(index)) {
      return AppThemes.blue;
    }
    return AppThemes.orange;
  }
}
