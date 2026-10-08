import 'package:drag_and_drop_game/models/emoji.dart';

final class EmojisAvaliable {
  final List<int> indexP1 = [];
  final List<int> indexP2 = [];
  final List<bool> emojiAvaliable = .generate(
    EmojisInfo.emojis.length,
    (index) => true,
  );
}