import 'package:dio/dio.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/API_Constant.dart';

class ApiCLint {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}
