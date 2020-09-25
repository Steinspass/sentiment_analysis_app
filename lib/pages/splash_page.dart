import 'package:flutter/material.dart';
import 'package:sentiment_analysis/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Sentiment Analysis',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Color(0xFF8C6EC4),
        ),
      ),
      image: Image.asset('assets/theater.png'),
      gradientBackground: LinearGradient(
        colors: [ 
          Color(0xFF90B54A),
          Color(0xFF38C79C), 
          Color(0xFF8F66FF),
          Color(0xFFFF66A7)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,

      ),
      photoSize: 50.0,
      loaderColor: Color(0xFF8C6EC4), 
    );
  }
}