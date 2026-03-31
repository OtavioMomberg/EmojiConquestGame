import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.cyan,  
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => goChooseEmojisPage(context), 
              child: const Text("Jogar")
            )
          ]
        )
      )
    );
  }
  

  void goChooseEmojisPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.chooseEmoji
    );
  }
}