import 'package:flutter/material.dart';
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
  const GamePage({super.key});

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
  String playerTurn = "X";
  GamePageArgs? args;
  
  @override
  void initState() {
    super.initState();

    colorsModel = ColorsModel(rand, [true, false, false, false], []);
    colorsModel.getColorsToColorOption();

    int val = rand.nextInt(colorsModel.selectedColor.length) + 1;
    playerTurn = val % 2 == 0 ? "X" : "Y";

    getFields();
    initializeDefenseEmoji();
    configPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as GamePageArgs;

      defenseEmoji.p1Emojis = args!.player1Emojis;
      defenseEmoji.p2Emojis = args!.player2Emojis;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan, toolbarHeight: 0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(10),
            color: Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 0),
                    Text("Vez de: $playerTurn", style: const TextStyle(fontSize: 20)),
                    FieldClassInfo(seeInfo: seeInfo, imageIndex: 1),
                  ],
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
                          if (isSorted) return;

                          if (defenseEmoji.defenseEmojiSelected[index]!.attack > 0) return;

                          if (playerTurn == "X") {
                            if(defenseEmoji.p1Emojis.length < 2) return;
                            if (defenseEmoji.defenseEmojiInField[0]) return;
                          }else {
                            if(defenseEmoji.p2Emojis.length < 2) return;
                            if (defenseEmoji.defenseEmojiInField[1]) return;
                          }

                          defenseEmoji.defenseEmojiSelected[index] = await getDefense();

                          if (defenseEmoji.defenseEmojiSelected[index] != null && defenseEmoji.defenseEmojiSelected[index]!.attack > 0) {
                            playerTurn == "X" ? defenseEmoji.defenseEmojiInField[0] = true : defenseEmoji.defenseEmojiInField[1] = true;
                              defenseEmoji.defenseEmojiPlayer["player"] = playerTurn;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: index % 2 == 0
                            ? index == 0
                              ? const EdgeInsets.only(right: 10, bottom: 10)
                              : const EdgeInsets.only(right: 10)
                            : index == 1
                              ? const EdgeInsets.only(left: 10, bottom: 10)
                              : const EdgeInsets.only(left: 10),
                            
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
                          ),
                        )
                      );
                    }
                  )
                ),
                DraggableEmoji(
                  player: player.toMap(),
                  isSorted: isSorted,
                  color: color
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
                  widthFactor: 0.5,
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
      [EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0)],
      [EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0)], 
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
          color = colorsModel.listColors[selectedValue];
          configPlayer();
          print(player);
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

    changePlayerTurn();
    configPlayer();

    print(defenseEmoji.defenseEmojiInField);
    if (defenseEmoji.defenseEmojiInField[0]) defenseEmoji.defenseEmojiTurns[0] += 1;
    if (defenseEmoji.defenseEmojiInField[1]) defenseEmoji.defenseEmojiTurns[1] += 1;

    print(defenseEmoji.defenseEmojiTurns);
    if (defenseEmoji.defenseEmojiTurns[0] == turns) defenseEmoji.removeDefenseEmoji(0);
    if (defenseEmoji.defenseEmojiTurns[1] == turns) defenseEmoji.removeDefenseEmoji(1);
    
    setState(() => isSorted = false);
  }

  Future<EmojiData> getDefense() async {
    final index = await showDialog<int>(
      context: context, 
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             const Text("Escolha sua defesa"),
             IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
          ],
        ),
        content: DefenseSelector(emojis: playerTurn == "X" ? defenseEmoji.p1Emojis : defenseEmoji.p2Emojis)
      )
    );

    if (index == null) return EmojiData(emoji: "", emojiClass: EmojiClass.neutro, attack: 0);

    defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1] = (playerTurn == "X") ? defenseEmoji.p1Emojis[index] : defenseEmoji.p2Emojis[index];
    playerTurn == "X" ? defenseEmoji.p1Emojis.removeAt(index) : defenseEmoji.p2Emojis.removeAt(index);
    print("SAIU: ${defenseEmoji.p1Emojis}");
    print("SAIU: ${defenseEmoji.p2Emojis}");
    return defenseEmoji.emojiSelected[playerTurn == "X" ? 0 : 1];
  }

  void seeInfo(int index) {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(index == 0 ? "Relação entre Classes" : "Relação entre Campos"),
            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ImageWidget(imagePath: index == 0 ? "images/class_hierarchy.png" : "images/field_type_relation_class.png"),
          ],
        ),
      ),
    );
  }

  void showResult(String winner) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: <Widget>[
            Icon(Icons.emoji_events, size: 40, color: Colors.blue),
            const Text("Vencedor", style: TextStyle(color: Colors.blue)),
            Icon(Icons.emoji_events, size: 40, color: Colors.blue)
          ]
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            Material(
              elevation: 10,
              shadowColor: Colors.blue.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.blue,
                  )
                ),
                child: Center(
                  child: Text(
                    winner.toUpperCase(), 
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ),
            ),
            const SizedBox(height: 20)
          ]
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), 
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, 
              side: BorderSide(
                color: Colors.blue
              )
            ),
            child: const Text("Home")
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.chooseEmoji), 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            ),
            child: Text("Jogar novamente?")
          )
        ]
      )
    );
  }
}
