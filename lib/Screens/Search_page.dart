import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:prayer/Models/Prayer_model.dart';
import 'package:prayer/Providers/Times_Provider.dart';
import 'package:prayer/Services/Prayer_Services.dart';
import 'package:prayer/help/Globals.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prayer/Services/location_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });
  }

  String? cityName;

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: pressed == false ? Color(0xff1E1D2B) : Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Card(
                margin: EdgeInsets.only(left: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: pressed == false ? Color(0xff0177FB) : Color(0xff00B761),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 25, bottom: 12, top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Back",
                          style: GoogleFonts.roboto(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Search for a city:',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                onSubmitted: (data) async {
                  setState(() {});
                  cityName = data;
                  PrayerTimesService service = PrayerTimesService();
                  PrayerTimesModel? times =
                      await service.getTimes(cityName: cityName!);
                  Provider.of<TimesProvider>(context, listen: false).timeData =
                      times;
                  if ('${Provider.of<TimesProvider>(context, listen: false).timeData?.status.toString()}' ==
                      "Success.") {
                    city = cityName!;
                    final pref = await SharedPreferences.getInstance();
                    pref.setString('city', city);
                    print(city);
                    Navigator.pop(context);
                  }
                  // else {ScaffoldMessenger.of(context).showSnackBar(snackBar);print('snackbar');}
                },
                cursorColor: Colors.grey,
                cursorHeight: 25,
                onChanged: (data) {
                  cityName = data;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 33, top: 20, bottom: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      PrayerTimesService service = PrayerTimesService();
                      PrayerTimesModel? times =
                          await service.getTimes(cityName: cityName!);
                      Provider.of<TimesProvider>(context, listen: false)
                          .timeData = times;

                      if (Provider.of<TimesProvider>(context, listen: false)
                              .timeData!
                              .status
                              .toString() ==
                          "Success.") {
                        city = cityName!;
                        final pref = await SharedPreferences.getInstance();
                        pref.setString('city', city);
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.black54,
                    icon: Icon(FontAwesomeIcons.magnifyingGlass),
                    padding: EdgeInsets.only(right: 25),
                  ),
                  filled: true,
                  fillColor: Color(0xffCFD7DC),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffCFD7DC)),
                      borderRadius: BorderRadius.circular(100)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffCFD7DC)),
                      borderRadius: BorderRadius.circular(100)),
                  labelText: 'Enter a city',
                  labelStyle: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w800),
                  hintText: 'Ex: Riyadh,Saudi Arabia',
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xffCFD7DC),
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "OR",
                  style: GoogleFonts.roboto(color: Color(0xffCFD7DC)),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xffCFD7DC),
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  locationService();
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      UserLocation.lat, UserLocation.long);
                  print(placemarks[0].locality);
                  cityName = placemarks[0].locality;
                  PrayerTimesService service = PrayerTimesService();
                  PrayerTimesModel? times =
                      await service.getTimes(cityName: cityName!);
                  Provider.of<TimesProvider>(context, listen: false).timeData =
                      times;
                  if ('${Provider.of<TimesProvider>(context, listen: false).timeData?.status.toString()}' ==
                      "Success.") {
                    city = cityName!;
                    final pref = await SharedPreferences.getInstance();
                    pref.setString('city', city);
                    print(city);
                    Navigator.pop(context);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color:
                      pressed == false ? Color(0xff0177FB) : Color(0xff00B761),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.mapLocationDot,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "GPS",
                            style: GoogleFonts.roboto(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ));
  }
}
