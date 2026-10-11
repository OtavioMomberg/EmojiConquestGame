import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/data/game_initial_data.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/export_widgets_game_screen.dart';

class const GameScreen({
  required final GameInitialData playersData, 
  super.key
}) extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _gameService = GameService.instance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: <Widget>[
              GameHeader(),
              
              const SizedBox(height: 10),

              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height * .5,
                  minHeight: size.height * .4
                ),
                child: FieldsGrid()
              ),

              ValueListenableBuilder(
                valueListenable: _gameService.draggableColor,
                builder: (_, color, _) {
                  return IgnorePointer(
                    ignoring: color == AppColors.gray,
                    child: DraggableEmoji(color: color),
                  );
                }
              ),

              const SizedBox(height: 20),

              ColorPicker(gameService: _gameService),

              const SizedBox(height: 20),

              FractionallySizedBox(
                widthFactor: .5,
                child: ValueListenableBuilder(
                  valueListenable: _gameService.blockSortButton,
                  builder: (_, ignoring, _) {
                    return IgnorePointer(
                      ignoring: ignoring,
                      child: SortButton(
                        gameService: _gameService
                      )
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}