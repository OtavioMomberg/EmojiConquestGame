import 'package:material_ui/material_ui.dart';

import 'dart:math';

import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/emojis_avaliable.dart';
import 'package:drag_and_drop_game/models/players_emojis.dart';

const playerOne = 1;
const playerTwo = 2;
const _sortRange = 4;

enum PlayerId { x, y }

typedef DialogFunction = Future<void> Function({required int player});

class SelectEmojiService {
  late final VoidCallback setState;
  late final DialogFunction dialog;

  final player = AudioService.instance();
  final PlayersEmojis _playersEmojis = PlayersEmojis();
  final EmojisAvaliable _emojisAvaliable = EmojisAvaliable();

  PlayerId _sortPlayerToStart = .x;
  PlayerId _displayPlayer = .x;
  int _contEmoji = 0;
  
  int get contEmoji => _contEmoji;
  PlayerId get sortPlayerToStart => _sortPlayerToStart;
  String get displayPlayer => _displayPlayer == .x ? "X" : "Y";

  List<bool> get emojiAvaliable => _emojisAvaliable.emojiAvaliable;
  List<EmojiData> get player1Emojis => _playersEmojis.player1Emojis;
  List<EmojiData> get player2Emojis => _playersEmojis.player2Emojis;

  void getFunctions({
    required VoidCallback getSetState,
    required DialogFunction getDialog
  }) {
    setState = getSetState;
    dialog = getDialog;
  }

  void _switchDisplay() {
    _displayPlayer = (_displayPlayer == .x) ? .y : .x;
  }

  void sortPlayer() {
    int value = Random().nextInt(_sortRange) + 1;
    _sortPlayerToStart = (value % 2 == 0) ? .x : .y;
    _sortPlayerToStart = .y;
    _displayPlayer = sortPlayerToStart;
    switchPalyers();
  }

  void selectEmoji({required int index}) async {
    _contEmoji += 1;

    if (player1Emojis.length < 4) {
      _playersEmojis.player1Emojis.add(EmojisInfo.emojis[index]);
      _emojisAvaliable.indexP1.add(index);
      setState();
      if (player1Emojis.length == 4) {
        await dialog(player: playerOne);
        setState();
      }
      return;
    }

    if (player2Emojis.length <= 4) {
      _playersEmojis.player2Emojis.add(EmojisInfo.emojis[index]);
      _emojisAvaliable.indexP2.add(index);
      setState();
      if (player2Emojis.length == 4) {
        await dialog(player: playerTwo);
        setState();
      }
    }
  }

  void dialogResponseAction({required bool response}) {
    _contEmoji = 0;
    switch (response) {
      case true: {
        _resetEmojisTile(response: true);
        _clearEmojisLists();
        break;
      }
      case false: {
        _switchDisplay();
        _resetEmojisTile(response: false);
        break;
      }
    }
  }

  void _resetEmojisTile({required bool response}) {
    final index = (_emojisAvaliable.indexP2.isEmpty)
      ? _emojisAvaliable.indexP1
      : _emojisAvaliable.indexP2;

    for (int i = 0; i < index.length; i++) {
      _emojisAvaliable.emojiAvaliable[index[i]] = response;
    }
  }

  void _clearEmojisLists() {
    if (_emojisAvaliable.indexP2.isEmpty) {
      _playersEmojis.player1Emojis.clear();
      _emojisAvaliable.indexP1.clear();
      return;
    }
    _playersEmojis.player2Emojis.clear();
    _emojisAvaliable.indexP2.clear();
  }

  Color getTileColor({required int index}) {
    return emojiAvaliable[index]
      ? AppThemes.grayBluish
      : _emojisAvaliable.indexP1.contains(index)
      ? AppThemes.blue
      : _emojisAvaliable.indexP2.contains(index)
      ? AppThemes.orange
      : AppThemes.grayBluish;
  }

  void switchPalyers() {
    if (_sortPlayerToStart == .x) { return; }

    final aux = player1Emojis;

    _playersEmojis.player1Emojis.clear();
    _playersEmojis.player1Emojis.addAll(player2Emojis);

    _playersEmojis.player2Emojis.clear();
    _playersEmojis.player2Emojis.addAll(aux);
  }
}
