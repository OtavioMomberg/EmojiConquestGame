import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:drag_and_drop_game/audio_services/audio_helper.dart';
import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/game_screen_data.dart';
import 'package:drag_and_drop_game/models/emoji.dart';

class const SelectEmojisScreen({super.key}) extends StatefulWidget {
  @override
  State<SelectEmojisScreen> createState() => _SelectEmojisScreenState();
}

class _SelectEmojisScreenState extends State<SelectEmojisScreen> {
  final player = AudioService.instance();
  final _sortRange = 4;
  List<EmojiData> player1Emojis = [];
  List<EmojiData> player2Emojis = [];
  List<int> indexP1 = [];
  List<int> indexP2 = [];
  List<bool> emojiAvaliable = .generate(30, (index) => true);
  bool player1Completed = false;
  String sortPlayerToStart = "";
  String displayPlayer = "";
  int contEmoji = 0;

  @override
  void initState() {
    super.initState();

    player.setupAudios(start: startLastSetup);

    int value = Random().nextInt(_sortRange) + 1;
    sortPlayerToStart = value % 2 == 0 ? "X" : "Y";
    displayPlayer = sortPlayerToStart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha seus Emojis"),
        centerTitle: true,
        backgroundColor: AppThemes.lightGray,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppThemes.white,
      ),
      body: Container(
        height: .infinity,
        width: .infinity,
        padding: const .all(10),
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: Column(
          mainAxisAlignment: .center,
          spacing: 10,
          children: <Widget>[
            Text(
              "Emojis selecionados de $displayPlayer: ${contEmoji.toString()}/4",
              style: const TextStyle(color: AppThemes.white),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: Emoji.emojiStatsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const .only(
                      right: 5,
                      left: 5,
                      bottom: 10,
                    ),
                    child: IgnorePointer(
                      ignoring: emojiAvaliable[index] ? false : true,
                      child: Material(
                        elevation: 5,
                        color: emojiAvaliable[index]
                          ? AppThemes.grayBluish
                          : indexP1.contains(index) &&
                              sortPlayerToStart == "X"
                          ? AppThemes.blue
                          : indexP1.contains(index) &&
                              sortPlayerToStart == "Y"
                          ? AppThemes.orange
                          : sortPlayerToStart == "Y"
                          ? AppThemes.blue
                          : AppThemes.orange,
                        type: .card,
                        borderRadius: AppThemes.stdBorderRadius,
                        child: InkWell(
                          borderRadius: AppThemes.stdBorderRadius,
                          onTap: () {
                            player.play(audio: .button1);
                            selectEmoji(index);
                            setState(
                              () => emojiAvaliable[index] =
                                  !emojiAvaliable[index],
                            );
                          },
                          child: Center(
                            child: Text(
                              Emoji.emojiStatsList[index].emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectEmoji(int index) async {
    contEmoji += 1;
    if (player1Emojis.length < 4) {
      player1Emojis.add(Emoji.emojiStatsList[index]);
      indexP1.add(index);
      if (player1Emojis.length == 4) {
        await confirmEmojis(1);
        setState(() {});
      }
      return;
    }

    if (player2Emojis.length <= 4) {
      player2Emojis.add(Emoji.emojiStatsList[index]);
      indexP2.add(index);
      if (player2Emojis.length == 4) {
        await confirmEmojis(2);
        setState(() {});
      }
    }
  }

  Future<void> confirmEmojis(int player) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppThemes.gray,
        title: const Center(
          child: Text(
            "Confirmar Emojis",
            style: TextStyle(color: AppThemes.white),
          ),
        ),
        content: SizedBox(
          height: 200,
          width: 250,
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: <Widget>[
              Row(
                mainAxisAlignment: .center,
                spacing: 20,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (contEmoji == 4) contEmoji = 0;
                      int len = player == 1 ? indexP1.length : indexP2.length;
                      for (int i = 0; i < len; i++) {
                        emojiAvaliable[player == 1 ? indexP1[i] : indexP2[i]] =
                            true;
                      }
                      player == 1
                          ? player1Emojis.clear()
                          : player2Emojis.clear();
                      player == 1 ? indexP1.clear() : indexP2.clear();

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: const TextStyle(
                        color: AppThemes.white,
                      ),
                    ),
                  ),
                  Material(
                    color: AppThemes.white,
                    borderRadius: AppThemes.stdBorderRadius,
                    child: InkWell(
                      borderRadius: AppThemes.stdBorderRadius,
                      splashColor: displayPlayer == "X"
                          ? AppThemes.blue
                          : AppThemes.orange,
                      onTap: () {
                        if (contEmoji == 4) contEmoji = 0;
                        displayPlayer = (displayPlayer == "X") ? "Y" : "X";
                        int len = player == 1 ? indexP1.length : indexP2.length;
                        for (int i = 0; i < len; i++) {
                          emojiAvaliable[player == 1
                                  ? indexP1[i]
                                  : indexP2[i]] =
                              false;
                        }
                        Navigator.pop(context);
                        if (player == 2) goToGamePage();
                      },
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: const Text(
                            "Confirmar",
                            style: TextStyle(
                              color: AppThemes.gray,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToGamePage() {
    if (sortPlayerToStart == "Y") {
      final aux = player1Emojis;
      player1Emojis = player2Emojis;
      player2Emojis = aux;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.game,
      arguments: GameScreenData(
        player1Emojis: player1Emojis,
        player2Emojis: player2Emojis,
        playerTurn: sortPlayerToStart,
      ),
    );
  }
}
