import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.BackGround),
            fit: BoxFit.fill)              
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[         
            const SizedBox(height: 30),
            Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
            const SizedBox(height: 20),
            buildSearchTextField(),
            SizedBox(height: 10),
            Text("Most Recently",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),),
            Text("Suras List",
            textAlign: TextAlign.start,      
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
            ),
            buildsuraslistview()       
          ],
        ),
      ),
    );
  }
  
  Widget buildSearchTextField() {
     OutlineInputBorder border= OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary,width: 2),
          borderRadius: BorderRadius.circular(10),         
        );
    return TextField(
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        labelText:'Sura Name',
        labelStyle: TextStyle(color: AppColors.white,fontSize: 16
        ),
        prefixIcon: Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        child:
        SvgPicture.asset(AssetsManager.QuranSvgRepo)),
        ),
        cursorColor: Colors.white,
        style: TextStyle(
          color: AppColors.white,
        ),
        
      );
  }
  
  Widget buildsuraslistview() {
    return Expanded(
      child: ListView.builder(itemCount: 100, itemBuilder:(context, index) {
        return Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image:DecorationImage(image:AssetImage(AssetsManager.SurasNum),
                fit: BoxFit.fill)
              ),
              child: Center(
                child: Text("${index + 1}",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16, 
                  fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        );
        
      }
      ),
    );
    }
  }
