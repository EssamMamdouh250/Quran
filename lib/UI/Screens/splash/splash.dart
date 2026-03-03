
import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/home/HomeScreen.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';

class Splash extends StatefulWidget {
  static const String routeName = 'splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
      Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Homescreen.routeName);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AssetsManager.SplashScreen,width: double.infinity,height: double.infinity,fit: BoxFit.fill,
      ),
    );
}
}
