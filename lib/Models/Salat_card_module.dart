import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer/Screens/home.dart';
// import 'package:provider/provider.dart';
// import '../Providers/Times_Provider.dart';

class salatCard extends StatefulWidget {
  salatCard({Key? key, required this.salatName, required this.salatTime})
      : super(key: key);

  String? salatName;
  String? salatTime;

  @override
  State<salatCard> createState() => _salatCardState();
}

class _salatCardState extends State<salatCard> {
  bool notify = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: pressed == false ? Color(0xff0177FB) : Color(0xff00B761),
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              SizedBox(width: 15),
              IconButton(
                onPressed: () {
                  setState(() {
                    notify = !notify;
                  });
                },
                icon: notify == true
                    ? Icon(FontAwesomeIcons.bell, size: 23, color: Colors.white)
                    : Icon(FontAwesomeIcons.bellSlash,
                        size: 23, color: Colors.white),
              ),
              SizedBox(width: 7),
              Text(
                widget.salatName!,
                style: GoogleFonts.changa(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Spacer(flex: 1),
              Text(
                widget.salatTime!,
                textAlign: TextAlign.start,
                style: GoogleFonts.changa(fontSize: 25, color: Colors.white),
              ),
              SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }
}
