import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prayer/Models/Prayer_model.dart';

class PrayerTimesService {

  Future<PrayerTimesModel?> getTimes({ String? cityName}) async {
    PrayerTimesModel? PrayerModel;
    try {
      String baseUrl = 'https://muslimsalat.com';
      String apiKey = 'ef6c941709aa588a9c6e6cdea95884ac';
      http.Response response =
      await http.get(Uri.parse('$baseUrl/$cityName.json?key=$apiKey'));
      Map<String, dynamic> data = jsonDecode(response.body);
      PrayerModel = PrayerTimesModel.fromJson(data);
    }
    catch(e){
      print('failed');
    }


    return PrayerModel;
  }
}
