import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final _firestore = FirebaseFirestore.instance;

  // void getEvents() async {
  //   final events = await _firestore.collection('events').get();
  //   for (var event in events.docs) {
  //     print(event.data());
  //   }
  // }

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
        title: Text("This is Events Page"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: eventsSteam,
              child: Text('get events'),
            ),
            StreamBuilder(
              stream: _firestore.collection('events').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final events = snapshot.data?.docs;
                //List<Text> eventsWidgets = [];
                List<Widget> eventsWidgets = [];
                for (var event in events!) {
                  final eventName = event.get('name');
                  final eventabout = event.get('about');
                  //final eventsWidget = Text('$eventName \n $eventabout ');
                  Text name = Text(
                    '$eventName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                  Text about = Text(
                    '$eventabout',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  );
                  final eventsWidget = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      name,
                      about,
                      SizedBox(
                        child: Divider(
                          height: 10,
                        ),
                      )
                    ],
                  );
                  eventsWidgets.add(eventsWidget);
                }
                return Column(
                  children: eventsWidgets,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
