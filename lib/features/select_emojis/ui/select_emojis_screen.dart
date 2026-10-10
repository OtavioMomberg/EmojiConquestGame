import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';
import 'package:drag_and_drop_game/features/select_emojis/ui/widgets/emoji_selection_grid.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/shared/data/game_initial_data.dart';

class const SelectEmojisScreen({super.key}) extends StatefulWidget {
  @override
  State<SelectEmojisScreen> createState() => _SelectEmojisScreenState();
}

class _SelectEmojisScreenState extends State<SelectEmojisScreen> {
  final _selectService = SelectEmojiService();

  @override
  void initState() {
    super.initState();

    _selectService.player.setupAudios(start: startLastSetup);
    _selectService.getFunctions(
      getSetState: () => setState(() {}),
      getDialog: _confirmEmojis,
    );
    _selectService.sortPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            spacing: 10,
            children: <Widget>[
              const Text(
                "Escolha seus Emojis!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Emojis selecionados de ${_selectService.displayPlayer}: "
                "${_selectService.contEmoji.toString()}/4",
                style: const TextStyle(color: AppColors.white),
              ),
              Expanded(
                child: EmojiSelectionGrid(selectService: _selectService),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmEmojis({required int player}) async {
    final response =
        await CustomFeedback.confirmDialog(
          context: context,
          backgroundColor: AppColors.gray,
          title: "Confirmar Emojis",
          fontColor: AppColors.white,
          content: "\nDeseja trocar de emojis?\n",
          buttonColor: AppColors.white,
          buttonFontColor: AppColors.gray,
        ) ??
        true;

    if (!mounted) {
      return;
    }

    _selectService.dialogResponseAction(response: response);
    if (player == playerTwo && !response) {
      _goGameScreen();
    }
  }

  void _goGameScreen() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.game,
      arguments: GameInitialData(
        player1Emojis: _selectService.player1Emojis,
        player2Emojis: _selectService.player2Emojis,
        playerTurn: _selectService.sortPlayerToStart,
      ),
    );
  }
}
