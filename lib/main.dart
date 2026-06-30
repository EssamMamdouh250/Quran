import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/UI/Screens/home/HomeScreen.dart';
import 'package:quran/UI/Screens/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("havelocation")) {
    prefs.setBool("havelocation", false);
  }
  final documentsDirectory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(documentsDirectory.path),
  );

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
