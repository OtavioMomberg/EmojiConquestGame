import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:flutter/material.dart';

class DefenseSelector extends StatelessWidget {
  final List<EmojiData> emojis;
  const DefenseSelector({required this.emojis, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ...List.generate(emojis.length, (index) {
                return GestureDetector(
                  onTap:() {
                    Navigator.pop<int>(context, index);
                  },
                  child: Text(emojis[index].emoji, style: const TextStyle(fontSize: 20))
                );
              })
            ]
          )
        ]
      )
    );
  }
}