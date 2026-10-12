import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';

final class Notifiers {
  final turn = ValueNotifier<PlayerId>(.neutro);
  final draggableColor = ValueNotifier<Color>(AppColors.gray);
  final blockSortButton = ValueNotifier<bool>(false);
  final selectedColor = ValueNotifier<List<bool>>([true, false, false, false]);

  void dispose() {
    turn.dispose();
    draggableColor.dispose();
    blockSortButton.dispose();
    selectedColor.dispose();
  }
}