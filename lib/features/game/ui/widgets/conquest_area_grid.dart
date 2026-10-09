import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/features/game/data/colors.dart';
import 'package:drag_and_drop_game/features/game/data/defense_emoji.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/conquest_area.dart';

typedef OnTap = Future<void> Function({required int index});

class const ConquestAreaGrid({
  required final OnTap onTap,
  required final void Function([String?]) updateTurnState,
  required final ColorsModel colorsModel,
  required final DefenseEmoji defenseEmoji,
  required final AudioService audioPlayer,
  required final List<int> fieldsIndex,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: colorsModel.selectedColor.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTap(index: index),
          child: ConquestArea(
            player: audioPlayer,
            updateGameTurn: updateTurnState,
            removeDefenseEmoji: defenseEmoji.removeDefenseEmoji,
            getDefenseEmojiOwner: defenseEmoji.checkDefenseEmojiPlayer,
            initialColor: colorsModel.fieldColors[index],
            fieldIndex: fieldsIndex[index],
            defenseEmoji: defenseEmoji.defenseEmojiSelected[index]!.emoji == ""
              ? null
              : defenseEmoji.defenseEmojiSelected[index],
          ),
        );
      },
    );
  }
}
