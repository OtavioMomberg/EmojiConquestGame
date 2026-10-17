import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/shared/data/game_data.dart';
import 'package:drag_and_drop_game/shared/widgets/button.dart';
import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';
import 'package:drag_and_drop_game/features/select_emojis/ui/widgets/emoji_selection_grid.dart';

class const SelectEmojisScreen({super.key}) extends StatefulWidget {
  @override
  State<SelectEmojisScreen> createState() => _SelectEmojisScreenState();
}

class _SelectEmojisScreenState extends State<SelectEmojisScreen> 
  with RouterScreens {
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
        useSafeArea: true,
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
              "${_selectService.contEmoji}/4",
              style: const TextStyle(color: AppColors.white),
            ),
            Expanded(
              child: EmojiSelectionGrid(
                selectService: _selectService
              )
            )
          ]
        )
      )
    );
  }

  Future<void> _confirmEmojis({required int player}) async {
    final response = await CustomFeedback.rawDialog<bool>(
      context: context,
      barrierDismissible: false,
      backgroundColor: AppColors.gray,
      shadowColor: AppColors.grayBluish,
      title: const Center(
        child: Text(
          "Confirmar Emojis", 
          style: TextStyle(color: AppColors.white)
        )
      ),
      content: const Text(""),
      actions: [
        Row(
          spacing: 8,
          children: <Widget>[
            Expanded(
              child: Button(
                text: "Não", 
                shadowColor: AppColors.grayBluish,
                onTap: () => Navigator.pop(context, false)
              )
            ),
            Expanded(
              child: Button(
                text: "Sim", 
                shadowColor: AppColors.grayBluish,
                onTap: () => Navigator.pop(context, true)
              )
            ),
          ],
        ),
      ]
    ) ?? false;

    if (!mounted) { return; }

    _selectService.dialogResponseAction(response: response);

    if (player == playerTwo && response) { 
      navigate(
        context: context, 
        screen: AppRoutes.game, 
        arguments: GameData(
          player1Emojis: _selectService.player1Emojis,
          player2Emojis: _selectService.player2Emojis,
          playerToStart: _selectService.sortPlayerToStart
        ),
        type: .pushReplacementNamed
      );
    }
  }
}