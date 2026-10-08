import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/features/rules/ui/widgets/rules.dart';
import 'package:drag_and_drop_game/features/rules/ui/widgets/rules_header.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const RulesScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.darkGray,
      body: FormattedContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RulesHeader(
                  onPressed: () {
                    AudioService.instance().play(audio: .button2);
                    Navigator.pop(context);
                  }
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: .centerLeft,
                  child: Text(
                    "Objetivo do Jogo:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: AppThemes.white
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "O objetivo é conquistar 3 das 4 áreas de "
                  "conquista ou derrotar todos os emojis do adversário.",
                  style: TextStyle(
                    color: AppThemes.white
                  ),
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: .centerLeft,
                  child: Text(
                    "Regras:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: AppThemes.white
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Rules()
              ]
            )
          )
        )
      )
    );
  }
}