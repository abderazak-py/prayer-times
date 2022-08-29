import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer/Models/Salat_card_module.dart';
import 'package:prayer/Providers/Times_Provider.dart';
import 'package:prayer/help/Globals.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Prayer_model.dart';
import '../Services/Prayer_Services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getSelectedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: pressed == false ? Color(0xff1E1D2B) : Colors.white,
          body: Provider.of<TimesProvider>(context)
                      .timeData
                      ?.status
                      ?.toString() ==
                  "Failed."
              ? Column(
                  children: [
                    SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'SearchPage');
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        color: Color(0xffCFD7DC),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                size: 23,
                                color: Color(0xff4C526C),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Search",
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff4C526C)),
                              ),
                              Spacer(
                                flex: 11,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Image(image: AssetImage("images/home.png")),
                    Text(
                      'Press Search for Prayer Times',
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'SearchPage');
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          color: Color(0xffCFD7DC),
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                Icon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 23,
                                  color: Color(0xff4C526C),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search",
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff4C526C)),
                                ),
                                Spacer(
                                  flex: 11,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.locationDot,
                              color: pressed == false
                                  ? Colors.white
                                  : Color(0xFF030E12),
                              size: 20,
                            ),
                            padding: EdgeInsets.only(left: 20, bottom: 3),
                          ),
                          Text(
                            Provider.of<TimesProvider>(context)
                                    .timeData
                                    ?.address ??
                                '----,----',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: pressed == false
                                    ? Colors.white
                                    : Color(0xFF030E12)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      salatCard(
                          salatName: 'Fajr',
                          salatTime: Provider.of<TimesProvider>(context)
                                  .timeData
                                  ?.fajr
                                  .toString() ??
                              '--:-- --'),
                      salatCard(
                          salatName: 'Dhuhr',
                          salatTime: Provider.of<TimesProvider>(context)
                                  .timeData
                                  ?.dhuhr
                                  .toString() ??
                              '--:-- --'),
                      salatCard(
                          salatName: 'Asr',
                          salatTime: Provider.of<TimesProvider>(context)
                                  .timeData
                                  ?.asr
                                  .toString() ??
                              '--:-- --'),
                      salatCard(
                          salatName: 'Maghrib',
                          salatTime: Provider.of<TimesProvider>(context)
                                  .timeData
                                  ?.maghrib
                                  .toString() ??
                              '--:-- --'),
                      salatCard(
                          salatName: 'isha',
                          salatTime: Provider.of<TimesProvider>(context)
                                  .timeData
                                  ?.isha
                                  .toString() ??
                              '--:-- --'),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            '${Provider.of<TimesProvider>(context).timeData?.temp ?? '---'}°C',
                            style: GoogleFonts.changa(
                                color: pressed == false
                                    ? Colors.white
                                    : Color(0xFF030E12),
                                fontSize: 25),
                          ),
                          Spacer(
                            flex: 6,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() async {
                                  pressed = !pressed;
                                  final pref =
                                      await SharedPreferences.getInstance();
                                  pref.setBool('lightMode', pressed);
                                });
                              },
                              icon: pressed == false
                                  ? Icon(FontAwesomeIcons.solidSun,
                                      color: Colors.white, size: 25)
                                  : Icon(FontAwesomeIcons.moon,
                                      color: Colors.black87, size: 25)),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }

  getSelectedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      city = pref.getString('city')!;
      pressed = pref.getBool('lightMode')!;
      print('city is $city');
    });
    PrayerTimesService service = PrayerTimesService();
    PrayerTimesModel? times = await service.getTimes(cityName: city);
    Provider.of<TimesProvider>(listen: false, context).timeData = times;
  }
}
