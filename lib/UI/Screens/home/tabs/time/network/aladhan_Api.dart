import 'package:dio/dio.dart';
import 'package:quran/UI/Screens/home/tabs/time/network/API_Constant.dart';

class AladhanApi {
  final Dio dio ;
  Future<Response> getPrayerTimes({
    required String date,
    required String city,
    required String country,
  }) async {
    try {
      final response = await dio.get(
        "${ApiConstants.prayerTimes}/$date",
        queryParameters: {"city": city, "country": country},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  AladhanApi({required this.dio});
}
