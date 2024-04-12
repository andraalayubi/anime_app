import 'dart:io';
import 'package:anime_app/app_theme.dart';
import 'package:anime_app/components/list_vertical_anime.dart';
import 'package:anime_app/components/list_horizontal_anime.dart';
import 'package:anime_app/components/home_page.dart';
import 'package:anime_app/fitness_app/fitness_app_home_screen.dart';
import 'package:anime_app/home_screen.dart';
// import 'package:anime_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  //Memastikan bahwa semua widgets Flutter telah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  //Mengatur orientasi layar aplikasi ke portrait
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Mengatur tampilan sistem UI (status bar, navigation bar) sesuai platform
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Anime42',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.android,
      ),
      home: HomePage(),
    );
  }
}

//mengonversi kode hex menjadi nilai integer
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
