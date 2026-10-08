import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:drag_and_drop_game/services/select_emoji_service.dart';
import 'package:drag_and_drop_game/ui/widgets/emoji_selection_grid.dart';
import 'package:drag_and_drop_game/ui/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/models/game_screen_data.dart';

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
      backgroundColor: AppThemes.darkGray,
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
                  color: AppThemes.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Emojis selecionados de ${_selectService.displayPlayer}: "
                "${_selectService.contEmoji.toString()}/4",
                style: const TextStyle(color: AppThemes.white),
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
    final response = await CustomFeedback.confirmDialog(
      context: context,
      backgroundColor: AppThemes.gray,
      title: "Confirmar Emojis",
      fontColor: AppThemes.white,
      content: "\nDeseja trocar de emojis?\n",
      buttonColor: AppThemes.white,
      buttonFontColor: AppThemes.gray,
    ) ?? false;

    if (!mounted) { return; }

    _selectService.dialogResponseAction(response: response);
    if (player == playerTwo && !response) { _goGameScreen(); }
  }

  void _goGameScreen() {
    _selectService.switchPalyers();

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.game,
      arguments: GameScreenData(
        player1Emojis: _selectService.player1Emojis,
        player2Emojis: _selectService.player2Emojis,
        playerTurn: _selectService.sortPlayerToStart,
      ),
    );
  }
}
