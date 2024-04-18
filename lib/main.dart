import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anime_app/pages/home_page.dart';
import 'package:anime_app/utils/service_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesService prefsService = PreferencesService();
  runApp(MyApp(prefsService: prefsService));
}

class MyApp extends StatelessWidget {
  final PreferencesService prefsService;

  MyApp({required this.prefsService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PreferencesService>(
      create: (_) => prefsService,
      child: Consumer<PreferencesService>(
        builder: (context, prefs, child) {
          return MaterialApp(
            title: 'Anime42',
            debugShowCheckedModeBanner: false,
            theme: prefs.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
