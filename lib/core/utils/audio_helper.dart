import 'package:audioplayers/audioplayers.dart';

const _buttonSound1 = "audios/button_click1.mp3";
const _buttonSound2 = "audios/button_click2.mp3";
const _defenseEmojiSound = "audios/defense_emoji_sound.mp3";
const _emojiPlacementSound = "audios/emoji_placement_sound.mp3";
const _errorSound = "audios/error_sound.mp3";
const _generalSound = "audios/general_use_sound.mp3";
const _victorySound = "audios/victory_sound.mp3";

const startFirstSetup = 0;
const endFirstSetUp = 2;
const startLastSetup = 2;

enum Audios { button1, button2, defense, placement, error, general, victory }

final class AudioService._() {
  static final _instance = AudioService._();
  factory instance() => _instance;

  final _button1 = AudioPlayer();
  final _button2 = AudioPlayer();
  final _defense = AudioPlayer();
  final _placement = AudioPlayer();
  final _error = AudioPlayer();
  final _general = AudioPlayer();
  final _victory = AudioPlayer();

  final _audioList = <InitAudios>[];

  bool _isPlayersDisposed = false;

  void _createAudioList() {
    _audioList.addAll([
      InitAudios(player: _button1, audioPath: _buttonSound1),
      InitAudios(player: _button2, audioPath: _buttonSound2),
      InitAudios(player: _defense, audioPath: _defenseEmojiSound),
      InitAudios(player: _placement, audioPath: _emojiPlacementSound),
      InitAudios(player: _error, audioPath: _errorSound),
      InitAudios(player: _general, audioPath: _generalSound),
      InitAudios(player: _victory, audioPath: _victorySound),
    ]);
  }

  Future<void> setupAudios({required int start, int? end}) async {
    _ensurePlayersAreAlive();
    if (_audioList.isEmpty) {
      _createAudioList();
    }
    for (var audio in _audioList.sublist(start, end)) {
      await audio.player.setReleaseMode(.stop);
      await audio.player.setPlayerMode(.lowLatency);
      await audio.player.setSource(AssetSource(audio.audioPath));
    }
  }

  AudioPlayer _getPlayer({required Audios audio}) {
    switch (audio) {
      case .button1: return _button1;
      case .button2: return _button2;
      case .defense: return _defense;
      case .error: return _error;
      case .general: return _general;
      case .placement: return _placement;
      case .victory: return _victory;
    }
  }

  Future<void> play({required Audios audio}) async {
    _ensurePlayersAreAlive();

    final player = _getPlayer(audio: audio);

    await player.stop();
    await player.resume();
  }

  Future<void> disposePlayers() async {
    if (_isPlayersDisposed) { return; }

    for (var audio in _audioList) {
      await audio.player.dispose();
    }
    _isPlayersDisposed = true;
  }

  void _ensurePlayersAreAlive() {
    if (_isPlayersDisposed) {
      throw StateError("[ERROR] => [Players has already been disposed]");
    }
  }
}

final class InitAudios({
  required final AudioPlayer player,
  required final String audioPath,
});
