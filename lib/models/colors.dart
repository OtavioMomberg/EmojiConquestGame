import 'package:flutter/material.dart';
import 'dart:math';

class ColorsModel {
  static List<Color> colorsList = [
    Colors.black,
    Colors.white,
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
    Colors.purpleAccent,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.yellow
  ];

  List<bool> selectedColor;
  List<Color> listColors;
  Random rand;

  ColorsModel(Random random, this.selectedColor, this.listColors) : rand = random;

  void getColorsToColorOption() {
    List<int> indexList = [];
    int index = 0;

    while(indexList.length < (selectedColor.length * 2)) {
      index = rand.nextInt(colorsList.length);

      if (!indexList.contains(index)) indexList.add(index);
    }
    
    for (int i=0; i<indexList.length; i++) {
      listColors.add(colorsList[indexList[i]]);
    }
  }
}