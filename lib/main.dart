import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString("assets/fonts/OFL.txt");
    yield LicenseEntryWithLineBreaks(["Google Fonts - Electrolize"], license);
  });

  await SystemChrome.setPreferredOrientations([
    .portraitUp, .portraitDown]);

  await AudioService.instance()
    .setupAudios(start: startFirstSetup, end: endFirstSetUp);

  runApp(const EmojiConquest());
}

class const EmojiConquest({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Emoji Conquest",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppThemes.gray),
        fontFamily: "Electrolize",
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) => 
        AppRoutes.getRoute(settings)
    );
  }
}
