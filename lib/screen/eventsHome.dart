import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfu_life_demo/screen/event.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final _firestore = FirebaseFirestore.instance;

  void eventsSteam() async {
    await for (var snapshot in _firestore.collection('events').snapshots()) {
      for (var event in snapshot.docs) {
        print(event.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events and News",
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7A060D),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: eventsSteam,
              child: const Text('get events'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: _firestore.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final events = snapshot.data?.docs;
                  List<EventBubble> eventsWidgets = [];
                  //List<Widget> eventsWidgets = [];
                  for (var event in events!) {
                    final eventName = event.get('name');
                    final eventAbout = event.get('about');
                    final isDone = event.get('isDone');
                    final eventDetail = event.get('detail');
                    final eventImages = event.get('img');
                    final eventImages2 = event.get('img2');

                    final eventsWidget = EventBubble(
                      name: eventName,
                      about: eventAbout,
                      isDone: isDone,
                      detail: eventDetail,
                      img: eventImages,
                      img2: eventImages2,
                    );

                    eventsWidgets.add(eventsWidget);
                  }
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true, // Add this line
                      children: eventsWidgets,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventBubble extends StatelessWidget {
  EventBubble({
    required this.name,
    required this.about,
    required this.isDone,
    required this.detail,
    required this.img,
    required this.img2,
  });

  final String name;
  final String about;
  final bool isDone;
  final String detail;
  final String img;
  final String img2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Text(about),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Event(
                  name: name,
                  about: about,
                  isDone: isDone,
                  detail: detail,
                  img: img,
                  img2: img2,
                ),
              ));
        },
      ),
    );
  }
}
