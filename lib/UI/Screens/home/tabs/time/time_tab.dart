import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Services/notificationService.dart';
import 'package:quran/Services/prayerNotificationManager.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/aladan_cubit.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/location_cubit_cubit.dart';
import 'package:quran/UI/Screens/home/tabs/time/cubit/location_cubit_state.dart';
import 'package:quran/UI/Screens/home/tabs/time/helper.dart';
import 'package:quran/UI/Screens/home/tabs/time/model/PrayerTimeModel.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/API_Clint.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/aladhan_Api.dart';
import 'package:quran/UI/Screens/home/tabs/time/repos/Timing_Repo.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timezone/timezone.dart' as tz;

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
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(
          create: (context) => AladanCubit(TimingRepe(aladhanApi: aladhanApi)),
        ),
      ],
      child: BlocListener<AladanCubit, AladanState>(
        listenWhen: (previous, current) =>
            current is AladanLoaded && previous != current,
        listener: (context, aladanState) {
          if (aladanState is AladanLoaded) {
            PrayerNotificationManager().scheduleAllPrayers(
              aladanState.times.prayTime,
            );
          }
        },
        child: BuildeUI(),
      ),
    );
  }
}

class BuildeUI extends StatefulWidget {
  const BuildeUI({super.key});

  @override
  State<BuildeUI> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BuildeUI> {
  late Map<String, dynamic> nextPrayer;
  String nName = "", riming = "", nTime = "";
  bool enabl = true, alarmed = false;
  List<PrayTime> p = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationCubit>().getUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationCubitState>(
      listener: (BuildContext context, LocationCubitState state) {
        if (state is LocationLoaded) {
          context.read<AladanCubit>().getTimes();
        }
      },
      child: BlocBuilder<LocationCubit, LocationCubitState>(
        builder: (context, locationState) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetsManager.backgroundtimeScreen),
                ),
              ),
              child: BlocBuilder<AladanCubit, AladanState>(
                builder: (context, aladanState) {
                  if (aladanState is AladanLoaded) {
                    List<PrayTime> prayers = aladanState.times.prayTime;
                    nextPrayer = getNextPrayer(prayers);
                    PrayTime info = prayers[nextPrayer["index"]];
                    nTime = info.time;
                    nName = info.name;
                    alarmed = info.alarm;
                    riming = nextPrayer["remaining"].toString().substring(0, 4);
                    enabl = false;

                    p = aladanState.times.prayTime;
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 40, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 80,
                              width: 160,
                              decoration: BoxDecoration(
                                color: AppColors.brown,
                                borderRadius: BorderRadius.circular(12),
                                border: BoxBorder.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              child: (aladanState is AladanLoaded)
                                  ? Column(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: AppColors.primary,
                                        ),
                                        Text(aladanState.times.hijriDate),
                                        Text(aladanState.times.date),
                                      ],
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.black,
                                      ),
                                    ),
                            ),

                            Container(
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.brown,
                                borderRadius: BorderRadius.circular(12),
                                border: BoxBorder.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColors.primary,
                                  ),
                                  if (locationState is LocationInitial)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.black,
                                      ),
                                    )
                                  else if (locationState is LocationLoaded)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(locationState.city),
                                        Text(locationState.country),
                                      ],
                                    )
                                  else if (locationState is LocationError)
                                    Text("Unknown location"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 50),
                        Container(
                          height: 200,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: (aladanState is! AladanLoaded)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Next Prayer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          nName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color:
                                                AppColors.blackwith0capacity60,
                                          ),
                                          child: Text(
                                            nTime,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Riming Time ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        alarmed
                                            ? Icon(
                                                Icons.notifications_on,
                                                size: 36,
                                                color: AppColors.white,
                                              )
                                            : Icon(
                                                Icons.notifications_off,
                                                size: 36,
                                                color: AppColors.white,
                                              ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color:
                                                AppColors.blackwith0capacity60,
                                          ),
                                          child: Text(
                                            riming,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 10),
                        if (aladanState is AladanLoaded)
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                              itemCount: p.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Skeletonizer(
                                    enabled: enabl,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          p[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          p[index].time,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              p[index].changeAlarm();
                                            });
                                            if (p[index].alarm) {
                                              await PrayerNotificationManager()
                                                  .schedulePrayer(
                                                    prayer: p[index],
                                                    id: index,
                                                  );
                                            } else {
                                              await Notificationservice
                                                  .instance
                                                  .flutterLocalNotificationsPlugin
                                                  .cancel(id: index);
                                            }
                                          },
                                          icon: p[index].alarm
                                              ? Icon(
                                                  Icons.notifications_on,
                                                  color: AppColors.white,
                                                )
                                              : Icon(
                                                  Icons.notifications_off,
                                                  color: AppColors.white,
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
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.brown,
              child: Icon(Icons.refresh, color: AppColors.primary),
              onPressed: () {
                context.read<LocationCubit>().getUserLocation();
              },
            ),
          );
        },
      ),
    );
  }
}
