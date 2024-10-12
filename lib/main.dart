import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mfu_life_demo/api/firebase_api.dart';
import 'package:mfu_life_demo/firebase_options.dart';
import 'package:mfu_life_demo/provider/eventButtonProvider.dart';
import 'package:mfu_life_demo/screen/eventsHome.dart';
import 'package:mfu_life_demo/screen/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => EventButtonProvider())],
    child: Demo(),
  ));
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        '/EventsScreen': (context) => Events(),
      },
    );
  }
}
