import 'package:anime_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Simulasi delay misalnya memuat data
    await Future.delayed(Duration(seconds: 3), () {});

    // Navigasi ke HomePage setelah loading
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(), // Ganti dengan halaman utama aplikasi Anda
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(), // Tampilkan indikator loading
            SizedBox(height: 20),
            Text('Loading...', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
