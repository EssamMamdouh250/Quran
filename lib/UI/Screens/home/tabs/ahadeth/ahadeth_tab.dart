import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class AhadethTab extends StatelessWidget {
  const AhadethTab({super.key});

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
        child: Column(
          children: [
            Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
            const SizedBox(height: 10),
            Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 450,

              margin: EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: AppColors.primary,

                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: .5,
                      child: Image.asset(
                        AssetsManager.mosqBlack,
                        height: 200,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // bottom decoration
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AssetsManager.mosq2,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  // corners
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        AssetsManager.hadethLeftCorner,
                        width: 60,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset(
                      AssetsManager.hadethLeftCorner,
                      width: 60,
                    ),
                  ),
                  // SingleChildScrollView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
