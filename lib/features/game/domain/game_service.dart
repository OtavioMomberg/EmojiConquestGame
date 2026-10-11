import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';

const turns = 6;

class GameService._() {
  static final _instance = GameService._();
  factory instance() => _instance;

  final audioPlayer = AudioHelper.instance();
  final _blockSortButton = ValueNotifier<bool>(false);
  final _selectedColor = ValueNotifier<List<bool>>([true, false, false, false]);
  final _draggableColor = ValueNotifier<Color>(AppColors.gray);
  
  ValueNotifier<bool> get blockSortButton => _blockSortButton; 
  ValueNotifier<List<bool>> get selectedColor => _selectedColor;
  ValueNotifier<Color> get draggableColor => _draggableColor;

  void dispose() {
    _blockSortButton.dispose();
    _selectedColor.dispose();
    _draggableColor.dispose();
  }

  Future<void> selectColor() async {
    _blockSortButton.value = true;
    _draggableColor.value = AppColors.gray;

    int length = _selectedColor.value.length;
    int index = Random().nextInt(length);
    int counter = 0;
    bool isLastIteration = false;

    while (counter <= length) {
      if (counter == length) { 
        isLastIteration = true;
        length = (index+1); 
      }  

      for (var i=0; i < length; i++) {
        _selectedColor.value = [false, false, false, false]; 
        _selectedColor.value[i] = true;

        if (isLastIteration && i == index) {
          audioPlayer.play(audio: .general);
          _blockSortButton.value = false;
          _draggableColor.value = AppThemes.colorPicker[i];
        }

        await Future.delayed(const Duration(milliseconds: 200));
      }
      counter++;
    }
  }
}