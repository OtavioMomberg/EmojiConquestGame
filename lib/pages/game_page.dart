import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/audio_services/audio_services.dart';
import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/defense_emoji.dart';
import 'package:drag_and_drop_game/models/game_page_args.dart';
import 'package:drag_and_drop_game/models/colors.dart';
import 'package:drag_and_drop_game/models/player.dart';
import 'package:drag_and_drop_game/models/field.dart';
import 'package:drag_and_drop_game/widgets/field_class_info.dart';
import 'package:drag_and_drop_game/widgets/image.dart';
import 'package:drag_and_drop_game/widgets/defense_selector.dart';
import 'package:drag_and_drop_game/widgets/draggable_emoji.dart';
import 'package:drag_and_drop_game/widgets/sort_button.dart';
import 'package:drag_and_drop_game/widgets/color_option.dart';
import 'package:drag_and_drop_game/widgets/conquest_area.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  final GamePageArgs ars;
  const GamePage({required this.ars, super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
  GamePageArgs? args;
  
  @override
  void initState() {
    super.initState();

    args = widget.ars;

    colorsModel = ColorsModel(rand, [true, false, false, false], []);
    colorsModel.getColorsToColorOption();

    playerTurn = args!.playerTurn;
    
    getFields();
    initializeDefenseEmoji();
    configPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 75, 77),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppThemes.gradient
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 10,
                  children: <Widget>[
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 0),
                    Text(
                      "Vez de: $playerTurn", 
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.w600,
                        color: playerTurn == "X" ? const Color.fromARGB(255, 71, 112, 189) : const Color.fromARGB(255, 177, 139, 84)
                      )
                    ),
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 1)
                  ]
                ),
                SizedBox(
                  height: constraints.maxHeight * .5,
                  width: constraints.maxHeight * .5,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: colorsModel.selectedColor.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (isSorted) {
                            AudioServices.play("audios/error_sound.mp3", 0.2);  
                            return;
                          }

                          if (defenseEmoji.defenseEmojiSelected[index]!.attack > 0) {
                            AudioServices.play("audios/error_sound.mp3", 0.2);  
                            return;
                          }

                          if (playerTurn == "X") {
                            if(defenseEmoji.p1Emojis.length < 2) {
                              AudioServices.play("audios/error_sound.mp3", 0.2);  
                              return;
                            }
                            if (defenseEmoji.defenseEmojiInField[0]) {
                              AudioServices.play("audios/error_sound.mp3", 0.2);  
                              return;
                            }
                          }else {
                            if(defenseEmoji.p2Emojis.length < 2) {
                              AudioServices.play("audios/error_sound.mp3", 0.2);  
                              return;
                            }
                            if (defenseEmoji.defenseEmojiInField[1]) {
                              AudioServices.play("audios/error_sound.mp3", 0.2);  
                              return;
                            }
                          }

                          defenseEmoji.defenseEmojiSelected[index] = await getDefense();

                          if (defenseEmoji.defenseEmojiSelected[index] != null && defenseEmoji.defenseEmojiSelected[index]!.attack > 0) {
                            playerTurn == "X" ? defenseEmoji.defenseEmojiInField[0] = true : defenseEmoji.defenseEmojiInField[1] = true;
                              defenseEmoji.defenseEmojiPlayer["player"] = playerTurn;
                              AudioServices.play("audios/defense_emoji_sound.mp3", 0.25);  
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: index % 2 == 0
                            ? index == 0
                              ? const EdgeInsets.only(right: 5, bottom: 10)
                              : const EdgeInsets.only(right: 5)
                            : index == 1
                              ? const EdgeInsets.only(left: 5, bottom: 10)
                              : const EdgeInsets.only(left: 5),  
                          child: ConquestArea(
                            updateGameTurn: updateTurnState,
                            removeDefenseEmoji: defenseEmoji.removeDefenseEmoji,
                            getDefenseEmojiOwner: defenseEmoji.checkDefenseEmojiPlayer,
                            initialColor: colorsModel.listColors[index+4],
                            fieldIndex: fieldsIndex[index],
                            defenseEmoji: 
                              defenseEmoji.defenseEmojiSelected[index]!.emoji == ""
                                ? null 
                                : defenseEmoji.defenseEmojiSelected[index],
                          )
                        )
                      );
                    }
                  )
                ),
                Opacity(
                  opacity: draggableOpacity ? 0.0 : 1.0,
                  child: DraggableEmoji(
                    player: player.toMap(),
                    isSorted: isSorted,
                    color: color
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ...List.generate(colorsModel.selectedColor.length, (index) {
                      return ColorOption(
                        index: index,
                        cor: colorsModel.listColors[index],
                        selectedColor: colorsModel.selectedColor[index]
                      );
                    })
                  ]
                ),
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: IgnorePointer(
                    ignoring: isSorted ? true : false,
                    child: Opacity(
                      opacity: isSorted ? 0.0 : 1.0,
                      child: SortButton(onTap: sortColor)
                    )
                  )
                )
              ]
            )
          );
        }
      )
    );
  }

  void initializeDefenseEmoji() {
    defenseEmoji = DefenseEmoji(
      args!.player1Emojis,
      args!.player2Emojis,
      [
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0), 
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0)
      ], 
      [false, false], 
      [0, 0], 
      [
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0), 
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0), 
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0), 
        EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0)
      ], 
      {"player": ""}, 
      0,
      rand
    );
  }

  void configPlayer() {
    player = Player(
      player: playerTurn,
      emoji: defenseEmoji.getEmoji(playerTurn),
      attack: playerTurn == "X"
        ? defenseEmoji.p1Emojis[defenseEmoji.emojiIndex].attack
        : defenseEmoji.p2Emojis[defenseEmoji.emojiIndex].attack,
      emojiClass: playerTurn == "X"
        ? defenseEmoji.p1Emojis[defenseEmoji.emojiIndex].emojiClass
        : defenseEmoji.p2Emojis[defenseEmoji.emojiIndex].emojiClass,
      color: color,
    );
  }

  void getFields() {
    int index = 0;

    while(fieldsIndex.length < colorsModel.selectedColor.length) {
      index = rand.nextInt(FieldType.fields.length);

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
        if (colorIterator == colorsModel.selectedColor.length-1 && i == selectedValue) {
          AudioServices.play("audios/general_use_sound.mp3", 0.1);
          color = colorsModel.listColors[selectedValue];
          configPlayer();
          if (draggableOpacity) draggableOpacity = false;
          break;
        }
        await Future.delayed(Duration(milliseconds: 200));
      }
      colorIterator += 1;
    }
  }
  
  void changePlayerTurn() {
    playerTurn == "X" ? playerTurn = "Y" : playerTurn = "X";
  }

  void updateTurnState([String? player]) {
    if (player != null) {
      player == "X" ? conquestedFields[0]+=1 : conquestedFields[1]+=1;

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

    if (defenseEmoji.defenseEmojiInField[0]) defenseEmoji.defenseEmojiTurns[0] += 1;
    if (defenseEmoji.defenseEmojiInField[1]) defenseEmoji.defenseEmojiTurns[1] += 1;

    if (defenseEmoji.defenseEmojiTurns[0] == turns) defenseEmoji.removeDefenseEmoji(0);
    if (defenseEmoji.defenseEmojiTurns[1] == turns) defenseEmoji.removeDefenseEmoji(1);
    
    setState(() => isSorted = false);
  }

  Future<EmojiData> getDefense() async {
    final index = await showDialog<int>(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 46, 46, 47),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text("Defesa", style: TextStyle(color: Color.fromARGB(255, 206, 206, 207))),
            IconButton(
              onPressed: () => Navigator.pop(context), 
              icon: const Icon(Icons.close, color: Color.fromARGB(255, 206, 206, 207))
            )
          ],
        ),
        content: DefenseSelector(emojis: playerTurn == "X" ? defenseEmoji.p1Emojis : defenseEmoji.p2Emojis)
      )
    );

    if (index == null) return EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0);

    defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1] = (playerTurn == "X") ? defenseEmoji.p1Emojis[index] : defenseEmoji.p2Emojis[index];
    playerTurn == "X" ? defenseEmoji.p1Emojis.removeAt(index) : defenseEmoji.p2Emojis.removeAt(index);
    return defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1];
  }

  void seeInfo(int index) {
    AudioServices.play("audios/button_click1.mp3", 0.1);
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(index == 0 ? "Classes" : "Campos"),
            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ImageWidget(imagePath: index == 0 ? "assets/images/class_hierarchy.png" : "assets/images/field_type_relation_class.png"),
          ],
        ),
      ),
    );
  }

  void showResult(String winner) {
    AudioServices.play("audios/victory_sound.mp3", 0.3);
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 46, 46, 47),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: <Widget>[
            Material(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.3),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(Icons.emoji_events, size: 40, color: Color.fromARGB(255, 206, 206, 207))
            ),
            Text("Vencedor", style: TextStyle(color: const Color.fromARGB(255, 206, 206, 207))),
            Material(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.3),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: const Icon(Icons.emoji_events, size: 40, color: Color.fromARGB(255, 206, 206, 207))
            )
          ]
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            Material(
              elevation: 10,
              shadowColor: winner == "Y" ? const Color.fromARGB(255, 177, 139, 84) : const Color.fromARGB(255, 71, 112, 189),
              color: const Color.fromARGB(255, 46, 46, 47).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1.5,
                    color: winner == "Y" ? const Color.fromARGB(255, 177, 139, 84) : const Color.fromARGB(255, 71, 112, 189),
                  )
                ),
                child: Center(
                  child: Text(
                    winner.toUpperCase(), 
                    style: TextStyle(
                      fontSize: 40,
                      color: winner == "Y" ? const Color.fromARGB(255, 177, 139, 84) : const Color.fromARGB(255, 71, 112, 189),
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              )
            ),
            const SizedBox(height: 20)
          ]
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), 
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 206, 206, 207), 
            ),
            child: Text("Home")
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.chooseEmoji);
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 206, 206, 207),
              foregroundColor: const Color.fromARGB(255, 46, 46, 47),
              elevation: 10,
              shadowColor: const Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.3)
            ),
            child: Text("Jogar novamente?")
          )
        ]
      )
    );
  }
}