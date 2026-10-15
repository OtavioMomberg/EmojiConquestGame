import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/features/home/rules/ui/rules.dart';
import 'package:drag_and_drop_game/shared/widgets/header.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const RulesScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        useSafeArea: true,
        child: Column(
          children: <Widget>[
            Header(
              label: "Como Jogar",
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 25),
            const Text(
              "O objetivo do jogo é conquistar 3 das 4 áreas de "
              "conquista ou derrotar todos os emojis do adversário.",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: .bold
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: .center,
              child: Text(
                "Regras:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: .bold,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Expanded(child: Rules())
          ],
        ),
      ),
    );
  }
}
