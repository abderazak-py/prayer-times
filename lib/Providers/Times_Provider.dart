import 'package:flutter/material.dart';
import 'package:prayer/Models/Prayer_model.dart';

class TimesProvider extends ChangeNotifier {
PrayerTimesModel? _timeData;

set timeData(PrayerTimesModel? times) {
  _timeData = times;
  notifyListeners();
}
PrayerTimesModel? get timeData => _timeData;
  
}