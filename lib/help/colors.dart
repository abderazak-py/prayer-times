import 'package:flutter/material.dart';
import 'package:prayer/help/Globals.dart';


Color backgroundColor = Color(0xff1E1D2B) ;
Color salatCardColor = Color(0xff0177FB);
Color fontinbackground = Colors.white;


void theme() {
  if (pressed == false) {
    Color backgroundColor = Color(0xff1E1D2B) ;
    Color salatCardColor = Color(0xff0177FB);
    Color fontinbackground = Colors.white;
  } else {
    Color backgroundColor = Colors.white;
    Color salatCardColor = Color(0xff00C077);
    Color fontinbackground = Color(0xFF030E12);
  }
}