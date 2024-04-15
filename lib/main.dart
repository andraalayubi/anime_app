import 'package:anime_app/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      title: 'Anime42',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingPage(),
    );
  }
}
