import 'package:cloud_firestore/cloud_firestore.dart';

class Model {
  String event;
  bool isAvailable;
  Timestamp date;

  Model({
    required this.event,
    required this.date,
    required this.isAvailable,
  });

  Model.fromJson(Map<String, Object?> json)
      : this(
          event: json['event']! as String,
          date: json['date']! as Timestamp,
          isAvailable: json['isAvailable'] as bool,
        );
}
