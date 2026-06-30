import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/ahadeth_tab.dart';
import 'package:quran/UI/Screens/home/tabs/quran/quran_tab.dart';
import 'package:quran/UI/Screens/home/tabs/radio/radio_tab.dart';
import 'package:quran/UI/Screens/home/tabs/sepha/sepha_tab.dart';
import 'package:quran/UI/Screens/home/tabs/time/time_tab.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = 'home';
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = const [
    QuranTab(),
    AhadethTab(),
    SephaTab(),
    RadioTab(),
    GetLocation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildButtomNavigationBar(),
      body: tabs[currentTabIndex],
    );
  }

  Widget buildButtomNavigationBar() {
    return Theme(
      data: ThemeData(canvasColor: AppColors.primary),
      child: BottomNavigationBar(
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.black,
        onTap: (clickedindex) {
          currentTabIndex = clickedindex;
          setState(() {});
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.Vector),
            label: "Quran",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.IcHadeth),
            label: "Ahadeth",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.IcSebha),
            label: "Sebha",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.IcRadio),
            label: "Radio",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsManager.IcTime),
            label: "Times",
          ),
        ],
      ),
    );
  }
}
