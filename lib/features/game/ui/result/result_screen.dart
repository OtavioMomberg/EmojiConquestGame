import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/core/utils/image_paths.dart';
import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/export_widgets_game_screen.dart';
import 'package:drag_and_drop_game/shared/widgets/button.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:material_ui/material_ui.dart';

class const ResultScreen({
  required final String winner, 
  super.key
}) extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with RouterScreens {
  final _gameService = GameService.instance();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _gameService.audioPlayer.play(audio: .victory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        useSafeArea: true,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 500
            ),
            child: Container(
              padding: AppThemes.containerStdPadding,
              decoration: BoxDecoration(
                borderRadius: AppThemes.stdBorderRadius,
                border: .all(color: AppColors.white.withValues(alpha: .8))
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "O vencedor é: ${widget.winner}",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 30
                    )
                  ),
                  const ImageRounded(imagePath: ImagePaths.emoji),
                  Button(
                    text: "Jogar Novamente", 
                    onTap: () => navigate(
                      context: context, 
                      screen: AppRoutes.home, 
                      type: .pushReplacementNamed
                    )
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}