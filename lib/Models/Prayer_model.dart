class PrayerTimesModel {
  String? status;
  String? address;
  String? fajr;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;
  String? temp;

  PrayerTimesModel({
     this.status,
     this.address,
     this.fajr,
     this.dhuhr,
     this.asr,
     this.maghrib,
     this.isha,
     this.temp,
  });

  factory PrayerTimesModel.fromJson(dynamic data) {
    return PrayerTimesModel(

        status: data['status_description'],
        address: data['address'],
        fajr: data['items'][0]['fajr'],
        dhuhr: data['items'][0]['dhuhr'],
        asr: data['items'][0]['asr'],
        maghrib: data['items'][0]['maghrib'],
        isha: data['items'][0]['isha'],
      temp: data['today_weather']['temperature'],
    );
  }


}
