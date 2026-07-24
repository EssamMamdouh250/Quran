import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/Hadeth_Details.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class AhadethTab extends StatefulWidget {
  AhadethTab({super.key});

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  final List<Map<String, dynamic>> azkarCategories = [
    {"name": "أذكار الصباح", "image": AssetsManager.mor},
    {"name": "أذكار المساء", "image": AssetsManager.even},
    {"name": "أذكار بعد الصلاة", "image": AssetsManager.pary},
    {"name": "تسابيح", "image": AssetsManager.tasabih},
    {"name": "أذكار النوم", "image": AssetsManager.sleep},
    {"name": "أذكار الاستيقاظ", "image": AssetsManager.weak},
    {"name": "أدعية قرآنية", "image": AssetsManager.quran},
    {"name": "أدعية الأنبياء", "image": AssetsManager.doaa},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.tagMahl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
              const SizedBox(height: 10),
              const Text(
                " أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: azkarCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarBage(
                              categorie: azkarCategories[index]["name"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.brown,
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                azkarCategories[index]["image"],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      azkarCategories[index]["name"],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
