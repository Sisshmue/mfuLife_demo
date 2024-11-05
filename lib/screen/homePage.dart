import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfu_life_demo/constants.dart';
import 'package:mfu_life_demo/screen/geminiScreen.dart';
import 'package:mfu_life_demo/screen/schedule.dart';
import 'eventsHome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: appbarStyle),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF7A060D),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Events()));
              },
              child: Text("Events"),
            ),
            SizedBox(
              width: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Text("AI"),
            ),
            SizedBox(
              width: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarPage()));
              },
              child: Text("Schedule"),
            ),
          ],
        ),
      ),
    );
  }
}
