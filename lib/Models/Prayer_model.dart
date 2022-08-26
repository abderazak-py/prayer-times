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
    required this.status,
    required this.address,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.temp,
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

  @override
  String toString() {
    return 'status: $status, address: $address, temp: $temp, isha time: $isha';
  }

}
