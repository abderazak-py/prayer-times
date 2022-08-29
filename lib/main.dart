import 'package:flutter/material.dart';
import 'package:prayer/Providers/Times_Provider.dart';
import 'package:prayer/Screens/Search_page.dart';
import 'package:provider/provider.dart';
import 'Screens/home.dart';


void main() {
  runApp(PrayerApp());
}

class PrayerApp extends StatelessWidget {
  const PrayerApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return TimesProvider();
      },
      child: MaterialApp(
        routes: {
          'SearchPage' : (context) => SearchPage(),
        },
        home: HomePage(),
      ),
    );
  }

}
