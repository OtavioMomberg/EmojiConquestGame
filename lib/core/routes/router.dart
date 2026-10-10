import 'package:material_ui/material_ui.dart';

enum NavigationType { pushNamed, pushReplacementNamed }

mixin RouterScreens {
  void navigate({
    required BuildContext context,
    required String screen,
    NavigationType type = .pushNamed,
    Object? arguments,
  }) {
    switch(type) {
      case .pushNamed:
        Navigator.pushNamed(
          context, 
          screen,
          arguments: arguments
        );
        break;
      case .pushReplacementNamed:
        Navigator.pushReplacementNamed(
          context,
          screen,
          arguments: arguments
        );
        break;
    } 
  }
}