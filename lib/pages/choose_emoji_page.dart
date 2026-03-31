import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/game_page_args.dart';
import 'package:drag_and_drop_game/models/emoji.dart';

class ChooseEmojiPage extends StatefulWidget {
  const ChooseEmojiPage({super.key});

  @override
  State<ChooseEmojiPage> createState() => _ChooseEmojiPageState();
}

class _ChooseEmojiPageState extends State<ChooseEmojiPage> {
  List<EmojiData> player1Emojis = [];
  List<EmojiData> player2Emojis = [];
  List<int> indexP1 = [];
  List<int> indexP2 = [];
  List<bool> emojiAvaliable = List.generate(30, (index) => true);
  bool player1Completed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escolha seus Emojis"),
        centerTitle: true,
        backgroundColor: Colors.cyan
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.cyan,  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                itemCount: Emoji.emojiStatsList.length,
                itemBuilder: (context, index) {
                  return IgnorePointer(
                    ignoring: emojiAvaliable[index] ? false : true,
                    child: Material(
                      color: emojiAvaliable[index] 
                        ? Colors.cyan 
                        : indexP1.contains(index)
                          ? Colors.yellowAccent
                          : Colors.orange,
                      type: MaterialType.circle,
                      child: InkWell(
                        onTap:() {
                          selectEmoji(index);
                          setState(() => emojiAvaliable[index] = !emojiAvaliable[index]);
                        },
                        child: Center(
                          child: Text(
                            Emoji.emojiStatsList[index].emoji,
                            style: const TextStyle(
                              fontSize: 20
                            )
                          )
                        )
                      )
                    )
                  );
                }
              )
            )
          ]
        )
      )
    );
  }

  void selectEmoji(int index) async {
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
        title: Center(child: const Text("Confirmar Emojis")),
        content: SizedBox(
          height: 250,
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      int len = player == 1 ? indexP1.length : indexP2.length;
                      for (int i=0; i<len; i++) {
                        emojiAvaliable[player == 1 ? indexP1[i] : indexP2[i]] = true; 
                      }
                      player == 1 ? player1Emojis.clear() : player2Emojis.clear();
                      player == 1 ? indexP1.clear() : indexP2.clear();
                      
                      Navigator.pop(context);
                    }, 
                    child: const Text("Cancelar")
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int len = player == 1 ? indexP1.length : indexP2.length;
                      for (int i=0; i<len; i++) {
                        emojiAvaliable[player == 1 ? indexP1[i] : indexP2[i]] = false; 
                      }
                      Navigator.pop(context); 
                      if (player == 2) goToGamePage();      
                    }, 
                    child: const Text("Confirmar")
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }

  void goToGamePage() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.game,
      arguments: GamePageArgs(
        player1Emojis,
        player2Emojis
      )
    );
  }
}