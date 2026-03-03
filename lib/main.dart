import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/home/HomeScreen.dart';
import 'package:quran/UI/Screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
         Homescreen.routeName: (_) => const Homescreen(),
         Splash.routeName: (_) => const Splash(),
      },
      initialRoute: Splash.routeName,
     
    );
  }
}