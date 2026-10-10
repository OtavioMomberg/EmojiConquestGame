import 'package:material_ui/material_ui.dart';

class const DefenseSelector({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            ....generate(4, (index) {
              return GestureDetector(
                onTap: () => Navigator.pop<int>(context, index),
                child: Text(
                  "EMOJI",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 20)
      ]
    );
  }
}
