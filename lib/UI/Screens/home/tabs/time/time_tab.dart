import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/aladan_cubit.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/location_cubit_cubit.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/location_cubit_state.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/API_Clint.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/aladhan_Api.dart';
import 'package:quran/UI/Screens/home/tabs/time/repos/Timing_Repo.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  @override
  Widget build(BuildContext context) {
    final dio = ApiCLint.dio;
    final aladhanApi = AladhanApi(dio: dio);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()..getUserLocation()),
        BlocProvider(
          create: (context) => AladanCubit(TimingRepe(aladhanApi: aladhanApi)),
        ),
      ],
      child: TimeTab(),
    );
  }
}

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationCubitState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            context.read<AladanCubit>().getTimes();
          }
        },
        child: _buildUI(),
      ),
    );
  }
}

Widget _buildUI() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AssetsManager.backgroundtimeScreen),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(AssetsManager.ImgLogo, width: 250, height: 170),
                  BlocBuilder<AladanCubit, AladanState>(
                    builder: (context, state) {
                      if (state is AladanInitial) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.brown,
                            image: DecorationImage(
                              image: AssetImage("assets/images/Group35.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        );
                      }
                      if (state is AladanLoaded) {
                        List<Map<String, String>> prayers = [
                          {"name": "Fajr", "time": state.times.fajr},
                          {"name": "Sunrise", "time": state.times.sunrise},
                          {"name": "Dhuhr", "time": state.times.dhuhr},
                          {"name": "Asr", "time": state.times.asr},
                          {"name": "Maghrib", "time": state.times.maghrib},
                          {"name": "Isha", "time": state.times.isha},
                        ];
                        return Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.brown,
                            image: DecorationImage(
                              image: AssetImage("assets/images/Group35.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      state.times.date,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Pray Time ",
                                          style: TextStyle(
                                            color: AppColors.brown,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          state.times.day,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      state.times.hijriDate,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (BuildContext context, int index) {
                                    final formatted = formatTime(
                                      prayers[index]["time"]!,
                                    );
      
                                    return Container(
                                      margin: EdgeInsets.all(2),
                                      height: 128,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.brown,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            prayers[index]["name"]!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
      
                                          Text(
                                            formatted["time"]!,
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            formatted["period"]!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text("you should add the alarm"),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
          Text("Azkar", style: TextStyle(color: AppColors.white)),
      
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 180,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: AppColors.primary,width: 2),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(AssetsManager.eveningazkar),
                        fit: BoxFit.fitWidth
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Evening Azkar",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 180,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: AppColors.primary,width: 2),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(AssetsManager.morningazkar),
                        fit: BoxFit.fitWidth
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Morning  Azkar",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Map<String, String> formatTime(String time) {
  final parts = time.split(":");
  int hour = int.parse(parts[0]);
  String minute = parts[1];

  String period = hour >= 12 ? "PM" : "AM";

  hour = hour % 12;
  if (hour == 0) hour = 12;

  return {"time": "$hour:$minute", "period": period};
}
