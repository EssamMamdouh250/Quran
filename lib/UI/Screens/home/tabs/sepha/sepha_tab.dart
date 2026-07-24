import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';

class SephaTab extends StatefulWidget {
  const SephaTab({super.key});

  @override
  State<SephaTab> createState() => _SephaTabState();
}
class _SephaTabState extends State<SephaTab> {
  int counter = 0;
  List<String> azkar = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
  ];

  int azkarIndex = 0;
  double turns = 0.0;

  void onSebhaPressed() {
    setState(() {
      counter++;
      turns += 0.05; 

      if (counter == 33) {
        counter = 0;
        azkarIndex = (azkarIndex + 1) % azkar.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.Backgroundsepha),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManager.ImgLogo,
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 10),
            
                const Text(
                  "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
             
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onSebhaPressed,
              child:Stack(
  alignment: Alignment.center,
  children: [
    Image.asset(
      AssetsManager.Sephabody,
      width: 325,
      height: 325,
    ),

    Transform.translate(
      offset: const Offset(0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            azkar[azkarIndex],
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black45,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$counter',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFDE7),
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
)
            ),
          ],
        ),
      ),
    );
  }
}