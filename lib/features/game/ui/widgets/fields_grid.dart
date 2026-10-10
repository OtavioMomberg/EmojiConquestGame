import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/field.dart';

class const FieldsGrid({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(child: Field());
      },
    );
  }
}
