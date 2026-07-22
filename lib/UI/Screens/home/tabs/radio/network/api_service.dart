import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/UI/Screens/home/tabs/radio/model/RadioModel.dart';
import 'package:quran/UI/Screens/home/tabs/radio/model/RecitersModel.dart';

class ApiService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';

  // جلب قائمة الإذاعات
  static Future<List<RadioModel>> fetchRadios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/radios?language=ar'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List radiosJson = data['radios'] ?? [];
        return radiosJson.map((json) => RadioModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // جلب قائمة القراء
  static Future<List<ReciterModel>> fetchReciters() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/reciters?language=ar'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List recitersJson = data['reciters'] ?? [];
        return recitersJson.map((json) => ReciterModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}