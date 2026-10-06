import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/export_models_game_screen.dart';
import 'package:drag_and_drop_game/ui/widgets/export_widgets_game_screen.dart';

import 'dart:math';

class const GameScreen({required final GameScreenData playersData, super.key})
    extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final audioPlayer = AudioService.instance();
  late DefenseEmoji defenseEmoji;
  late ColorsModel colorsModel;
  late Player player;
  final int turns = 6;
  final Random rand = Random();
  List<int> fieldsIndex = [];
  List<int> conquestedFields = [0, 0];
  Color color = Colors.transparent;
  int selectedValue = 0;
  int colorIterator = 0;
  bool isSorted = false;
  bool draggableOpacity = true;
  String playerTurn = "X";
  GameScreenData? args;

  @override
  void initState() {
    super.initState();

    args = widget.playersData;

    colorsModel = ColorsModel(
      selectedColor: [true, false, false, false],
      colorPickerColors: [],
      fieldColors: [],
    );
    colorsModel.getColors();

    playerTurn = args!.playerTurn;

    getFields();
    initializeDefenseEmoji();
    configPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.lightGray,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const .all(10),
            decoration: const BoxDecoration(gradient: AppThemes.gradient),
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  spacing: 10,
                  children: <Widget>[
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 0),
                    Material(
                      color: AppThemes.white,
                      elevation: 8,
                      shadowColor: playerTurn == "X"
                          ? AppThemes.blue.withValues(alpha: 0.5)
                          : AppThemes.orange.withValues(alpha: 0.5),
                      borderRadius: .circular(8),
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: Center(
                          child: Text(
                            "Turno: $playerTurn",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: .w600,
                              color: playerTurn == "X"
                                  ? AppThemes.blue
                                  : AppThemes.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 1),
                  ],
                ),
                SizedBox(
                  height: constraints.maxHeight * .5,
                  width: constraints.maxHeight * .5,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemCount: colorsModel.selectedColor.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (isSorted) {
                            audioPlayer.play(audio: .error);
                            return;
                          }

                          if (defenseEmoji.defenseEmojiSelected[index]!.attack >
                              0) {
                            audioPlayer.play(audio: .error);
                            return;
                          }

                          if (playerTurn == "X") {
                            if (defenseEmoji.p1Emojis.length < 2) {
                              audioPlayer.play(audio: .error);
                              return;
                            }
                            if (defenseEmoji.defenseEmojiInField[0]) {
                              audioPlayer.play(audio: .error);
                              return;
                            }
                          } else {
                            if (defenseEmoji.p2Emojis.length < 2) {
                              audioPlayer.play(audio: .error);
                              return;
                            }
                            if (defenseEmoji.defenseEmojiInField[1]) {
                              audioPlayer.play(audio: .error);
                              return;
                            }
                          }

                          defenseEmoji.defenseEmojiSelected[index] =
                              await getDefense();

                          if (defenseEmoji.defenseEmojiSelected[index] !=
                                  null &&
                              defenseEmoji.defenseEmojiSelected[index]!.attack >
                                  0) {
                            playerTurn == "X"
                                ? defenseEmoji.defenseEmojiInField[0] = true
                                : defenseEmoji.defenseEmojiInField[1] = true;
                            defenseEmoji.defenseEmojiPlayer["player"] =
                                playerTurn;
                            audioPlayer.play(audio: .defense);
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: index % 2 == 0
                              ? index == 0
                                    ? const .only(right: 5, bottom: 10)
                                    : const .only(right: 5)
                              : index == 1
                              ? const .only(left: 5, bottom: 10)
                              : const .only(left: 5),
                          child: ConquestArea(
                            player: audioPlayer,
                            updateGameTurn: updateTurnState,
                            removeDefenseEmoji: defenseEmoji.removeDefenseEmoji,
                            getDefenseEmojiOwner:
                                defenseEmoji.checkDefenseEmojiPlayer,
                            initialColor: colorsModel.fieldColors[index],
                            fieldIndex: fieldsIndex[index],
                            defenseEmoji:
                                defenseEmoji
                                        .defenseEmojiSelected[index]!
                                        .emoji ==
                                    ""
                                ? null
                                : defenseEmoji.defenseEmojiSelected[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Opacity(
                  opacity: draggableOpacity ? 0.0 : 1.0,
                  child: DraggableEmoji(
                    player: player.toMap(),
                    isSorted: isSorted,
                    color: color,
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: <Widget>[
                    ...List.generate(colorsModel.selectedColor.length, (index) {
                      return ColorOption(
                        index: index,
                        cor: colorsModel.colorPickerColors[index],
                        selectedColor: colorsModel.selectedColor[index],
                      );
                    }),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: IgnorePointer(
                    ignoring: isSorted ? true : false,
                    child: Opacity(
                      opacity: isSorted ? 0.0 : 1.0,
                      child: SortButton(onTap: sortColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void initializeDefenseEmoji() {
    defenseEmoji = DefenseEmoji(
      p1Emojis: args!.player1Emojis,
      p2Emojis: args!.player2Emojis,
      emojiSelected: [
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
      ],
      defenseEmojiInField:  [false, false],
      defenseEmojiTurns: [0, 0],
      defenseEmojiSelected: [
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
        EmojiData(emoji: "", emojiType: .neutro, attack: 0),
      ],
      defenseEmojiPlayer: {"player": ""},
      emojiIndex: 0,
    );
  }

  void configPlayer() {
    player = Player(
      player: playerTurn,
      emoji: defenseEmoji.getEmoji(playerTurn: playerTurn),
      attack: playerTurn == "X"
        ? defenseEmoji.p1Emojis[defenseEmoji.emojiIndex].attack
        : defenseEmoji.p2Emojis[defenseEmoji.emojiIndex].attack,
      emojiType: playerTurn == "X"
        ? defenseEmoji.p1Emojis[defenseEmoji.emojiIndex].emojiType
        : defenseEmoji.p2Emojis[defenseEmoji.emojiIndex].emojiType,
      color: color,
    );
  }

  void getFields() {
    int index = 0;

    while (fieldsIndex.length < colorsModel.selectedColor.length) {
      index = rand.nextInt(FieldHierarchies.fields.length);

      if (!fieldsIndex.contains(index)) fieldsIndex.add(index);
    }
  }

  Future<void> sortColor() async {
    isSorted = true;
    colorIterator = 0;
    selectedValue = rand.nextInt(colorsModel.selectedColor.length);

    while (colorIterator < colorsModel.selectedColor.length) {
      for (int i = 0; i < colorsModel.selectedColor.length; i++) {
        setState(() {
          colorsModel.selectedColor = [false, false, false, false];
          colorsModel.selectedColor[i] = true;
        });
        if (colorIterator == colorsModel.selectedColor.length - 1 &&
            i == selectedValue) {
          audioPlayer.play(audio: .general);
          color = colorsModel.colorPickerColors[selectedValue];
          configPlayer();
          if (draggableOpacity) draggableOpacity = false;
          break;
        }
        await Future.delayed(const Duration(milliseconds: 200));
      }
      colorIterator += 1;
    }
  }

  void changePlayerTurn() {
    playerTurn == "X" ? playerTurn = "Y" : playerTurn = "X";
  }

  void updateTurnState([String? player]) {
    if (player != null) {
      player == "X" ? conquestedFields[0] += 1 : conquestedFields[1] += 1;

      if (conquestedFields[0] == 3) {
        showResult(player);
      } else if (conquestedFields[1] == 3) {
        showResult(player);
      }
    }

    if (playerTurn == "X") {
      if (defenseEmoji.p1Emojis.isEmpty) showResult("Y");
    } else {
      if (defenseEmoji.p2Emojis.isEmpty) showResult("X");
    }

    changePlayerTurn();
    configPlayer();

    if (defenseEmoji.defenseEmojiInField[0]) {
      defenseEmoji.defenseEmojiTurns[0] += 1;
    }
    if (defenseEmoji.defenseEmojiInField[1]) {
      defenseEmoji.defenseEmojiTurns[1] += 1;
    }

    if (defenseEmoji.defenseEmojiTurns[0] == turns) {
      defenseEmoji.removeDefenseEmoji(index: 0);
    }
    if (defenseEmoji.defenseEmojiTurns[1] == turns) {
      defenseEmoji.removeDefenseEmoji(index: 1);
    }

    setState(() => isSorted = false);
  }

  Future<EmojiData> getDefense() async {
    final index = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppThemes.gray,
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            const Text("Defesa", style: TextStyle(color: AppThemes.white)),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: AppThemes.white),
            ),
          ],
        ),
        content: DefenseSelector(
          emojis: playerTurn == "X"
            ? defenseEmoji.p1Emojis
            : defenseEmoji.p2Emojis,
        ),
      ),
    );

    if (index == null) {
      return EmojiData(emoji: "", emojiType: .neutro, attack: 0);
    }

    defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1] = (playerTurn == "X")
      ? defenseEmoji.p1Emojis[index]
      : defenseEmoji.p2Emojis[index];
    playerTurn == "X"
      ? defenseEmoji.p1Emojis.removeAt(index)
      : defenseEmoji.p2Emojis.removeAt(index);
    return defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1];
  }

  void seeInfo(int index) {
    audioPlayer.play(audio: .button1);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppThemes.white,
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            Text(index == 0 ? "Classes" : "Campos"),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: .min,
          children: <Widget>[
            ImageWidget(
              imagePath: index == 0
                ? "assets/images/class_hierarchy.png"
                : "assets/images/field_type_relation_class.png",
            ),
          ],
        ),
      ),
    );
  }

  void showResult(String winner) {
    audioPlayer.play(audio: .victory);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppThemes.gray,
        title: Row(
          mainAxisAlignment: .spaceBetween,
          spacing: 10,
          children: <Widget>[
            Material(
              elevation: 5,
              shadowColor: AppThemes.white.withValues(alpha: 0.3),
              color: Colors.transparent,
              borderRadius: AppThemes.stdBorderRadius,
              child: const Icon(
                Icons.emoji_events,
                size: 40,
                color: AppThemes.white,
              ),
            ),
            const Text("Vencedor", style: TextStyle(color: AppThemes.white)),
            Material(
              elevation: 5,
              shadowColor: AppThemes.white.withValues(alpha: 0.3),
              color: Colors.transparent,
              borderRadius: AppThemes.stdBorderRadius,
              child: const Icon(
                Icons.emoji_events,
                size: 40,
                color: AppThemes.white,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: .min,
          children: <Widget>[
            const SizedBox(height: 20),
            Material(
              elevation: 10,
              shadowColor: winner == "Y" ? AppThemes.orange : AppThemes.blue,
              color: AppThemes.gray.withValues(alpha: 0.7),
              borderRadius: AppThemes.largerBorderRadius,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: AppThemes.largerBorderRadius,
                  border: .all(
                    width: 1.5,
                    color: winner == "Y" ? AppThemes.orange : AppThemes.blue,
                  ),
                ),
                child: Center(
                  child: Text(
                    winner.toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      color: winner == "Y" ? AppThemes.orange : AppThemes.blue,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            style: TextButton.styleFrom(foregroundColor: AppThemes.white),
            child: Text("Home"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.selectEmojis);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemes.white,
              foregroundColor: AppThemes.gray,
              elevation: 10,
              shadowColor: AppThemes.white.withValues(alpha: 0.3),
            ),
            child: const Text("Jogar novamente?"),
          ),
        ],
      ),
    );
  }
}
