import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'authentication_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: "images/logo.png",
      splashIconSize: 250,
      backgroundColor: Color.fromRGBO(30, 136, 252, 1),
      nextScreen: Authentication(),
    );
  }
}
