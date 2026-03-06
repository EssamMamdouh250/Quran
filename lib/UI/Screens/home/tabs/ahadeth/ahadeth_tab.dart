import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/home/tabs/ahadeth/Hadeth_Details.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadAllHadith() async {
  List<Map<String, dynamic>> allHadeth = [];
  for (int i = 1; i <= 50; i++) {
    String content = await rootBundle.loadString('assets/Hadeeth/h$i.txt');
    List hadethcontent = content.split("\n");

    String hadethNumber = hadethcontent[0];
    String hadethNarator = hadethcontent.last;
    String hadethContent = hadethcontent
        .sublist(1, hadethcontent.length - 1)
        .join("\n");
    allHadeth.add({
      "hadithID": i,
      "hadethNumber": hadethNumber,
      "hadethNarator": hadethNarator,
      "hadethContent": hadethContent,
    });
  }

  return allHadeth;
}

class AhadethTab extends StatefulWidget {
  const AhadethTab({super.key});

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  List<Map<String, dynamic>> cont = [];
  @override
  void initState() {
    red();
    super.initState();
  }

  Future<void> red() async {
    final List<Map<String, dynamic>> conts = await loadAllHadith();
    print(conts.length);
    setState(() {
      cont = conts;
    });
  }

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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cont.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HadethDetails(hadeth: cont[index])));
                    },
                    child: BuildContainer(hadethcontent: cont[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {
  final Map<String, dynamic> hadethcontent;
  const BuildContainer({super.key, required this.hadethcontent});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 280,

      margin: EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: .2,
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
            child: Image.asset(AssetsManager.mosq2, fit: BoxFit.fitWidth),
          ),

          // corners
          Positioned(
            top: 10,
            left: 10,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(AssetsManager.hadethLeftCorner, width: 60),
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(AssetsManager.hadethLeftCorner, width: 60),
          ),

          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  hadethcontent["hadethNumber"] ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "JannaLT",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      "${hadethcontent["hadethContent"] ?? ""}\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "JannaLT",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  hadethcontent["hadethNarator"] ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "JannaLT",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
