import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../Sura_Details/Sura_details.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:quran/UI/Screens/utilites/quranlist.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<int> filterList = List.generate(114, (index) => index);
  void searchsura(String text) {
    filterList.clear();

    for (int i = 0; i < 114; i++) {
      if (Constantas.englishQuranSurahs[i].toLowerCase().contains(
            text.toLowerCase(),
          ) ||
          Constantas.arabicAuranSuras[i].contains(text)) {
        filterList.add(i);
      }
    }
    setState(() {});
  }

  get verses => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.BackGround),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
            const SizedBox(height: 20),
            buildSearchTextField(),
            SizedBox(height: 10),
            Text(
              "Suras List",
              textAlign: TextAlign.start,
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
            buildsuraslistview(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchTextField() {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
    return TextField(
      onChanged: searchsura,
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        labelText: 'Sura Name',
        labelStyle: TextStyle(color: AppColors.white, fontSize: 16),
        prefixIcon: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: SvgPicture.asset(AssetsManager.QuranSvgRepo),
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(color: AppColors.white),
    );
  }

  Widget buildsuraslistview() {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          int suraIndex = filterList[index];
          return InkWell(
            onTap: () async {
              List<String> suraVerses = await loadSura(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuraDetails(
                    suraName: Constantas.englishQuranSurahs[suraIndex],
                    suraIndex: suraIndex,
                    verses: suraVerses,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetsManager.SurasNum),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Constantas.englishQuranSurahs[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${Constantas.AyaNumber[index]} Verses',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  Constantas.arabicAuranSuras[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Future<List<String>> loadSura(int index) async {
    String content = await rootBundle.loadString(
      'assets/Suras/${index + 1}.txt',
    );
    List<String> verses = content.split("\n");
    return verses;
  }
}
