import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/data/player_id.dart';
import 'package:drag_and_drop_game/shared/data/game_data.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/export_widgets_game_screen.dart';

class const GameScreen({
  required final GameData playersData, 
  super.key
}) extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with RouterScreens {
  final _gameService = GameService.instance();

  @override
  void initState() {
    super.initState();
    _gameService.getResultFunction(resultF: _result);
    _gameService.setUpPlayers(gameData: widget.playersData);
    _gameService.initFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        padding: const .symmetric(horizontal: 10, vertical: 15),
        useSafeArea: true,
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: _gameService.turn,
              builder: (_, _, _) {
                return GameHeader(turn: _gameService.turnToStr());
              },
            ),

            const SizedBox(height: 10),

            Expanded(child: FieldsGrid(fields: _gameService.fields)),

            ValueListenableBuilder(
              valueListenable: _gameService.draggableColor,
              builder: (_, color, _) {
                return IgnorePointer(
                  ignoring: color == AppColors.gray,
                  child: DraggableEmoji(
                    color: color,
                    player: _gameService.getCurrentPlayer(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            ValueListenableBuilder(
              valueListenable: _gameService.selectedColor,
              builder: (_, isSelected, _) {
                return ColorPicker(isSelected: isSelected);
              },
            ),

            const SizedBox(height: 20),

            FractionallySizedBox(
              widthFactor: .5,
              child: ValueListenableBuilder(
                valueListenable: _gameService.blockSortButton,
                builder: (_, ignoring, _) {
                  return IgnorePointer(
                    ignoring: ignoring,
                    child: SortButton(
                      selectColor: _gameService.sortEmojiColor
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _result({required PlayerId winner}) {
    navigate(
      context: context, 
      screen: AppRoutes.result,
      arguments: winner,
      type: .pushReplacementNamed
    );
  }
}