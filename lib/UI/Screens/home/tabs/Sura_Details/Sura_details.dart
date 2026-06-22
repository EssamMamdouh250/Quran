import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:quran/UI/Screens/utilites/quranlist.dart';

class SuraDetails extends StatelessWidget {
  static const routeName = 'Sura_details';

  final String suraName;
  final int suraIndex;
  final List<String> verses;

  const SuraDetails({
    super.key,
    required this.suraName,
    required this.suraIndex,
    required this.verses,
  });

  @override
  Widget build(BuildContext context) {
    String arabicSuraName = Constantas.arabicAuranSuras[suraIndex];
    String suraText = "";
    for (int i = 0; i < verses.length; i++) {
      suraText += "${verses[i]} [${i + 1}] ";
    }
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          suraName,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AssetsManager.QuranLeftCorner,
                width: 92,
                height: 92,
                ),
                Text(
                  arabicSuraName,
                  style: const TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(AssetsManager.QuranRightCorner,
                width: 92, height: 92),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Text(
                  suraText,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            AssetsManager.SurasDetails,
            width: double.infinity,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}