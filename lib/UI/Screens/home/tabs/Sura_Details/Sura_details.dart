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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 217, 197),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetsManager.suraName),
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 60, // أو 80
                            child: Center(
                              child: Text(
                                arabicSuraName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (suraIndex != 0 && suraIndex != 8)
                        Text(
                          "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          children: [
                            for (int i = 0; i < verses.length; i++) ...[
                              TextSpan(
                                text: "${verses[i]} ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  height: 2,
                                  color: AppColors.black,
                                ),
                              ),

                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsManager.ayaNumer,
                                        width: 32,
                                        height: 32,
                                      ),

                                      Text(
                                        "${i + 1}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
