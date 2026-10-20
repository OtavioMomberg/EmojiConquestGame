import 'package:custom_feedback/custom_feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/data/emojis_dataset.dart';
import 'package:drag_and_drop_game/features/select_emojis/domain/select_emoji_service.dart';

enum Power { buff, nerf }

class const EmojiTile({
  required final SelectEmojiService selectService,
  required final int index,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !selectService.emojiAvaliable[index],
      child: Material(
        color: selectService.getTileColor(index: index),
        borderRadius: AppThemes.stdBorderRadius,
        child: InkWell(
          borderRadius: AppThemes.stdBorderRadius,
          onTap: () {
            selectService.player.play(audio: .button1);
            selectService.selectEmoji(index: index);
          },
          onLongPress: () {
            CustomFeedback.rawDialog(
              context: context,
              backgroundColor: AppColors.gray,
              shadowColor: AppColors.gray,
              title: Center(
                child: const Text(
                  "Emoji Info", 
                  style: TextStyle(color: AppColors.white)
                )
              ),
              content: Column(
                mainAxisSize: .min,
                children: <Widget>[
                  Text(
                    EmojisDataset.emojis[index].emoji, 
                    style: const TextStyle(fontSize: 50)
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: AppThemes.containerStdPadding,
                    decoration: BoxDecoration(
                      borderRadius: AppThemes.stdBorderRadius,
                      border: .all(color: AppColors.white)
                    ),
                    child: Column(
                      spacing: 10,
                      children: <Widget>[
                        _Container(
                            child: Align(
                              alignment: .center,
                              child: Text(
                                "Ataque: ${EmojisDataset.emojis[index].attack}", 
                                style: const TextStyle(
                                  color: AppColors.gray, 
                                  fontWeight: .bold
                                )
                              ),
                            ),
                          ),
                        _Container(
                          child: Align(
                            alignment: .center,
                            child: Text(
                              "Classe: ${EmojisDataset.emojis[index].emojiType.name}", 
                              style: const TextStyle(
                                color: AppColors.gray, 
                                fontWeight: .bold
                              )
                            ),
                          ),
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: .center,
                          children: <Widget>[
                            Expanded(
                              child: _IconText(
                                text: _getText(index: index, power: .buff), 
                                icon: Icons.arrow_upward,
                                power: .buff,
                              ),
                            ),
                            Expanded(
                              child: _IconText(
                                text: _getText(index: index, power: .nerf), 
                                icon: Icons.arrow_downward,
                                power: .nerf,
                              ),
                            )
                          ]
                        ),
                      ],
                    ),
                  )
                ]
              )
            );
          },
          child: Center(
            child: Text(
              EmojisDataset.emojis[index].emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Container({final Widget? child}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(8),
      decoration: BoxDecoration(
        borderRadius: AppThemes.stdBorderRadius,
        color: AppColors.white
      ),
      child: child,
    );
  }
}

class const _IconText({
  required final String text,
  required final IconData icon,
  required final Power power
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Container(
      child: Row(
        children: <Widget>[
          Icon(
            icon, 
            color: power == .buff 
              ? AppColors.blue 
              : AppColors.red
            ),
          Text(
            text, 
            style: TextStyle(
              color: power == .buff 
                ? AppColors.blue 
                : AppColors.red
            )
          )
        ]
      ),
    );
  }
}

String _getText({required int index, required Power power}) {
  final emoji = EmojiHierarchies.hierarchies.firstWhere(
    (e) => e.type == EmojisDataset.emojis[index].emojiType
  );
  return power == .buff ? emoji.strong.name : emoji.weak.name;
}