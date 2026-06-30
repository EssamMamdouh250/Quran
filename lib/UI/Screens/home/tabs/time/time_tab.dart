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
        BlocProvider(create: (context) => AladanCubit(TimingRepe(aladhanApi: aladhanApi)),
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
    child: Center(
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
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state is AladanLoaded) {
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
                            Text(state.times.date),
                            Text("Day"),
                            Text(state.times.hijriDate),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
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
  );
}
