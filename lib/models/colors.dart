import 'package:material_ui/material_ui.dart';
import 'dart:math';

final class ColorsModel({
  required var List<bool> selectedColor,
  required final List<Color> colorPickerColors,
  required final List<Color> fieldColors,
}) {
  static final List<Color> _colors = [
    Colors.amberAccent,
    Colors.blue,
    Colors.cyanAccent,
    Colors.brown,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.grey,
    Colors.indigo,
    Colors.lime,
    Colors.lightBlueAccent,
    Colors.orange,
    Colors.pinkAccent,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  final _random = Random();

  void getColors() {
    final colorPickerIndexes = _getColorsIndex();
    final fieldIndexes = _getColorsIndex();

    for (int i = 0; i < colorPickerIndexes.length; i++) {
      colorPickerColors.add(_colors[colorPickerIndexes[i]]);
      fieldColors.add(_colors[fieldIndexes[i]]);
    }
  }

  List<int> _getColorsIndex() {
    List<int> indexList = [];
    int index = 0;

    while (indexList.length < 4) {
      index = _random.nextInt(_colors.length);

      if (!indexList.contains(index)) {
        indexList.add(index);
      }
    }
    return indexList;
  }
}
