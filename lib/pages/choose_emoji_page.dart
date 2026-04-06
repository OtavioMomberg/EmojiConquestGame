import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/audio_services/audio_services.dart';
import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/game_page_args.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text(
          "Escolha seus Emojis", 
          style: GoogleFonts.electrolize(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 74, 75, 77),
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: AppThemes.gradient
        ), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1), 
                itemCount: Emoji.emojiStatsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
                    child: IgnorePointer(
                      ignoring: emojiAvaliable[index] ? false : true,
                      child: Material(
                        elevation: 5,
                        color: emojiAvaliable[index] 
                          ? const Color.fromARGB(255, 82, 92, 111)
                          : indexP1.contains(index)
                            ? const Color.fromARGB(255, 71, 112, 189)
                            : const Color.fromARGB(255, 177, 139, 84),
                        type: MaterialType.card,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap:() {
                            AudioServices.play("audios/clique_campo.mp3", 0.15);
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
                    ),
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
        backgroundColor:const Color.fromARGB(255, 46, 46, 47),
        title: Center(child: Text("Confirmar Emojis", style: GoogleFonts.electrolize(color: Colors.white))),
        content: SizedBox(
          height: 200,
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
                    child: Text("Cancelar", style: GoogleFonts.electrolize(color: Colors.white))
                  ),
                  Material(
                    color: const Color.fromARGB(255, 206, 206, 207),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: player == 1 
                        ? const Color.fromARGB(255, 71, 112, 189) 
                        : const Color.fromARGB(255, 177, 139, 84),
                      onTap: () {
                        int len = player == 1 ? indexP1.length : indexP2.length;
                        for (int i=0; i<len; i++) {
                          emojiAvaliable[player == 1 ? indexP1[i] : indexP2[i]] = false; 
                        }
                        Navigator.pop(context); 
                        if (player == 2) goToGamePage();      
                      },
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(
                            "Confirmar", 
                            style: GoogleFonts.electrolize(
                              color: const Color.fromARGB(255, 46, 46, 47),
                              fontWeight: FontWeight.bold
                            )
                          )
                        )
                      )
                    )
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