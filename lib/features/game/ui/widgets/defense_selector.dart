import 'package:drag_and_drop_game/shared/data/emoji_data.dart';
import 'package:material_ui/material_ui.dart';

class DefenseSelector extends StatelessWidget {
  final List<EmojiData> emojis;
  const DefenseSelector({required this.emojis, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Column(
        mainAxisAlignment: .center,
        children: <Widget>[
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              ....generate(emojis.length, (index) {
                return GestureDetector(
                  onTap:() {
                    Navigator.pop<int>(context, index);
                  },
                  child: Text(
                    emojis[index].emoji, 
                    style: const TextStyle(fontSize: 20)
                  )
                );
              })
            ]
          )
        ]
      )
    );
  }
}