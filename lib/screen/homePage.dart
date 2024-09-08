import 'package:flutter/material.dart';
import 'events.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Events()));
          },
          child: Text("Events"),
        ),
      ),
    );
  }
}
