import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Conquest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor:const Color.fromARGB(255, 46, 46, 47)),
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) => AppRoutes.dynamicRoute(settings),
    );
  }
}
