import 'package:flutter/material.dart';

import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class HadethDetails extends StatelessWidget {
  final Map<String, dynamic> hadeth;
  const HadethDetails({super.key, required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
        title: Text(
          "Hadith ${hadeth["hadithID"]}",
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: AppColors.black),

        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    hadeth["hadethNumber"] ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "JannaLT",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        "${hadeth["hadethContent"] ?? ""}\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "JannaLT",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    hadeth["hadethNarator"] ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "JannaLT",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,

              child: Image.asset(AssetsManager.QuranRightCorner, width: 60),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Image.asset(AssetsManager.QuranLeftCorner, width: 60),
            ),
          ],
        ),
      ),
    );
  }
}
