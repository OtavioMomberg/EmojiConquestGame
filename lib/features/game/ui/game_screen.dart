import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/data/game_initial_data.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/export_widgets_game_screen.dart';

class const GameScreen({required final GameInitialData playersData, super.key})
    extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.darkGray,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: <Widget>[
              GameHeader(),
              const SizedBox(height: 10),
              Flexible(child: FieldsGrid()),
              Opacity(opacity: 1.0, child: DraggableEmoji()),
              const SizedBox(height: 20),

              ColorPicker(),

              const SizedBox(height: 20),

              FractionallySizedBox(
                widthFactor: 0.5,
                child: IgnorePointer(
                  ignoring: false,
                  child: Opacity(opacity: 1.0, child: SortButton()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
