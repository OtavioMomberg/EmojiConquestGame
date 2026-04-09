import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/audio_services/audio_services.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/field.dart';
import 'package:drag_and_drop_game/models/player.dart';

class ConquestArea extends StatefulWidget {
  final void Function([String?]) updateGameTurn;
  final void Function(int, [bool?]) removeDefenseEmoji;
  final String Function() getDefenseEmojiOwner;
  final Color initialColor;
  final int fieldIndex;
  final EmojiData? defenseEmoji;

  const ConquestArea({
    required this.updateGameTurn,
    required this.removeDefenseEmoji,
    required this.getDefenseEmojiOwner,
    required this.initialColor,
    required this.fieldIndex,
    this.defenseEmoji,
    super.key
  });

  @override
  State<ConquestArea> createState() => _ConquestAreaState();
}

class _ConquestAreaState extends State<ConquestArea> {
  int acceptedDataX = 100;
  int acceptedDataY = 100;
  int changeValue = 0;
  int correctionValue = 0;
  late Field field;

  @override
  void initState() {
    super.initState();

    field = Field(index: widget.fieldIndex);
    field.setField();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      builder: (context, candidateItems, _) {
        return AnimatedScale(
          scale: candidateItems.isNotEmpty ? 1.1 : 1.0,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 500),
          child: Card(
            color: field.isConquested != null 
            ? widget.initialColor.withValues(alpha: 0.5) 
            : candidateItems.isNotEmpty 
              ? widget.initialColor.withValues(alpha: 0.8) 
              : widget.initialColor,
            elevation: 5,
            shadowColor: widget.initialColor.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "${field.fieldSelected}",
                  style: TextStyle(
                    color: widget.initialColor == Colors.black
                      ? const Color.fromARGB(255, 206, 206, 207)
                      : const Color.fromARGB(255, 33, 32, 32), 
                    fontWeight: FontWeight.w600
                  )
                ),
                if (widget.defenseEmoji != null)...[
                  Text(
                    "${widget.defenseEmoji?.emoji}  ${correctedDamage()} atk",
                    style: TextStyle(
                      color: widget.initialColor == Colors.black
                        ? const Color.fromARGB(255, 206, 206, 207)
                        : const Color.fromARGB(255, 33, 32, 32),
                      fontSize: 20, 
                      fontWeight: FontWeight.w600  
                    )
                  )
                ],
                Text(
                  "X: $acceptedDataX / Y: $acceptedDataY",
                  style: TextStyle(
                    color: widget.initialColor == Colors.black
                      ? const Color.fromARGB(255, 206, 206, 207)
                      : const Color.fromARGB(255, 33, 32, 32),  
                    fontWeight: FontWeight.w600
                  )
                )
              ]
            )
          )
        );
      },
      onAcceptWithDetails: (details) {
        AudioServices.play("audios/emoji_placement_sound.mp3", 0.3);
        checkDefenseEmoji();
        if (field.isConquested == true) {
          AudioServices.play("audios/error_sound.mp3", 0.3);
          return;
        }

        changeValue = details.data["color"] == widget.initialColor ? Player.changeValue() : 0;
        changeValue -= details.data["attack"] as int;
        changeValue += field.checkFieldAdvantage(details.data["emoji_class"]);

        if (details.data["player"] == "X") {
          if (!attackDefense(details.data["attack"], details.data["player"], details.data["emoji_class"], field.defenseEmojiOwner)) {
            acceptedDataX += changeValue <= 0 ? changeValue : 0;

            if (acceptedDataX <= 0) updateFieldState(details.data["player"]);
          }
        } else {
          if (!attackDefense(details.data["attack"], details.data["player"], details.data["emoji_class"], field.defenseEmojiOwner)) {
            acceptedDataY += changeValue <= 0 ? changeValue : 0;

            if (acceptedDataY <= 0) updateFieldState(details.data["player"]);
          }
        }
        widget.updateGameTurn(field.playerConquested);
        setState(() {});
      }
    );
  }

  void checkDefenseEmoji() {
    if (widget.defenseEmoji != null) {
      if (field.containDefenseEmoji == true) return;
      field.containDefenseEmoji = true;
      field.defenseEmojiOwner = widget.getDefenseEmojiOwner();
    }
  }

  int correctedDamage() {
    if (widget.defenseEmoji != null) {
      if (widget.defenseEmoji!.attack == 0) return 0;
      correctionValue = field.checkFieldAdvantage(widget.defenseEmoji!.emojiClass) * (-1);
      correctionValue += widget.defenseEmoji?.attack as int;
      return correctionValue < 0 ? 1 : correctionValue;
    }
    correctionValue = widget.defenseEmoji?.attack as int;
    return correctionValue;
  }

  bool attackDefense(int attack, String player, EmojiClass emojiPlayer, String? emojiOwner) {
    if (emojiOwner == null) return false;

    if (widget.defenseEmoji != null) {
      if (widget.defenseEmoji!.attack == 0) return false;

      if (player != emojiOwner) {

        correctionValue += Emoji.checkEmojiClassAdvantage(widget.defenseEmoji!.emojiClass, emojiPlayer);

        if ((correctionValue) <= attack) {
          widget.removeDefenseEmoji(player == "X" ? 1 : 0, true);
          player == "X" ? acceptedDataX -= (attack - correctionValue) : acceptedDataY -= (attack - correctionValue);
          return true;
        } else {
          widget.removeDefenseEmoji(player == "X" ? 0 : 1, false);
          return true;
        }
      }
    }
    return false;
  }

  void updateFieldState(String player) {
    field.isConquested = true;
    field.playerConquested = player;

    if (player == "X") {
      acceptedDataX = 0;
    } else {
      acceptedDataY = 0;
    }
  }
}
