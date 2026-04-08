import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/audio_services/audio_services.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:drag_and_drop_game/widgets/basic_button.dart';
import 'package:drag_and_drop_game/widgets/image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 75, 77),
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          gradient: AppThemes.gradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Material(
              elevation: 10,
              shadowColor: const Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 0.8,
                    color: Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.3)
                  )
                ),
                child: ImageWidget(imagePath: "assets/images/emoji_conquest_logo.png"),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: BasicButton(
                play: goChooseEmojisPage,
                text: "Jogar"
              )
            ),
            TextButton(
              onPressed: () => goToHowToPlayPage(context), 
              child: const Text("Como Jogar", style: TextStyle(color: Color.fromARGB(255, 206, 206, 207)))
            )
          ]
        )
      )
    );
  }
  
  void goChooseEmojisPage(BuildContext context) {
    AudioServices.play("audios/button_click2.mp3", 1);
    
    Navigator.pushNamed(
      context,
      AppRoutes.chooseEmoji
    );
  }
  
  void goToHowToPlayPage(BuildContext context) {
    AudioServices.play("audios/button_click2.mp3", 1);

    Navigator.pushNamed(
      context, 
      AppRoutes.howToPlay, 
    );
  }
}