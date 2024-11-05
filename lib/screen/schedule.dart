// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }
//
// class _CalendarPageState extends State<CalendarPage> {
//   CalendarFormat _calendarFormat = CalendarFormat.week;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   Map<DateTime, List<String>> _events = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStudentCourses();
//   }
//
//   // Fetch specific student's courses and organize them by date
//   Future<void> _fetchStudentCourses() async {
//     final response = await http.get(Uri.parse(
//         'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules'));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body)['data'];
//       setState(() {
//         _events = _mapCoursesToCalendar(data, 10); // Pass student_id = 10
//       });
//     } else {
//       throw Exception('Failed to load courses');
//     }
//   }
//
//   // // Map course data to calendar dates, filtering by specific student_id
//   // Map<DateTime, List<String>> _mapCoursesToCalendar(
//   //     List<dynamic> data, int studentId) {
//   //   final Map<DateTime, List<String>> events = {};
//   //
//   //   // Find student data by studentId
//   //   final studentData = data.firstWhere((student) => student['id'] == studentId,
//   //       orElse: () => null);
//   //
//   //   if (studentData != null) {
//   //     for (var course in studentData['courses']) {
//   //       for (var schedule in course['schedules']) {
//   //         DateTime courseDate =
//   //             _getNextOccurrence(schedule['day'], DateTime.now());
//   //         String courseName =
//   //             "${course['course_name']} (${course['type']})\nClassroom: ${schedule['classroom']}\n${schedule['start_time']} - ${schedule['end_time']}";
//   //
//   //         // Populate events based on schedule date and repeat weekly for a 16-week semester
//   //         for (int i = 0; i < 16; i++) {
//   //           DateTime occurrence = courseDate.add(Duration(days: 7 * i));
//   //           events[occurrence] = events[occurrence] ?? [];
//   //           events[occurrence]!.add(courseName);
//   //         }
//   //       }
//   //     }
//   //   }
//   //   return events;
//   // }
//
//   // Map course data to calendar dates, filtering by specific studentId
//   Map<DateTime, List<String>> _mapCoursesToCalendar(
//       List<dynamic> data, int studentId) {
//     final Map<DateTime, List<String>> events = {};
//
//     // Find student data by studentId
//     final studentData = data.firstWhere((student) => student['id'] == studentId,
//         orElse: () => null);
//
//     if (studentData != null) {
//       for (var course in studentData['courses']) {
//         for (var schedule in course['schedules']) {
//           DateTime courseDate =
//               _getNextOccurrence(schedule['day'], DateTime.now());
//           String courseName =
//               "${course['course_name']} (${course['type']})\nClassroom: ${schedule['classroom']}\n${schedule['start_time']} - ${schedule['end_time']}";
//
//           // Populate events based on schedule date and repeat weekly for a 16-week semester
//           for (int i = 0; i < 16; i++) {
//             DateTime occurrence = courseDate.add(Duration(days: 7 * i));
//             events[occurrence] = events[occurrence] ?? [];
//             events[occurrence]!.add(courseName);
//
//             // Debug print to check date mapping
//             print("Mapped event: $courseName on $occurrence");
//           }
//         }
//       }
//     } else {
//       print("Student with ID $studentId not found");
//     }
//
//     print("Final events map: $events");
//     return events;
//   }
//
//   // Get next occurrence of the specified day from current week
//   DateTime _getNextOccurrence(String day, DateTime reference) {
//     final dayOfWeekMap = {
//       'Monday': DateTime.monday,
//       'Tuesday': DateTime.tuesday,
//       'Wednesday': DateTime.wednesday,
//       'Thursday': DateTime.thursday,
//       'Friday': DateTime.friday,
//       'Saturday': DateTime.saturday,
//       'Sunday': DateTime.sunday,
//     };
//
//     int dayOfWeek = dayOfWeekMap[day]!;
//     int daysToAdd = (dayOfWeek - reference.weekday) % 7;
//     return reference
//         .add(Duration(days: daysToAdd >= 0 ? daysToAdd : daysToAdd + 7));
//   }
//
//   // // Get events for a specific day
//   // List<String> _getEventsForDay(DateTime day) {
//   //   return _events[DateTime(day.year, day.month, day.day)] ?? [];
//   // }
//
//   List<String> _getEventsForDay(DateTime day) {
//     DateTime normalizedDay = DateTime(day.year, day.month, day.day);
//     return _events[normalizedDay] ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Courses Schedule'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             focusedDay: _focusedDay,
//             firstDay: DateTime(2020),
//             lastDay: DateTime(2030),
//             calendarFormat: _calendarFormat,
//             eventLoader: _getEventsForDay,
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });
//             },
//             onFormatChanged: (format) {
//               setState(() {
//                 _calendarFormat = format;
//               });
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           const SizedBox(height: 8.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                       _getEventsForDay(_selectedDay ?? _focusedDay)[index]),
//                 );
//               },
//             ),
//
//             // child: ElevatedButton(
//             //     onPressed: () {
//             //       print(_getEventsForDay(_selectedDay ?? _focusedDay));
//             //       print(_selectedDay);
//             //       print(_focusedDay);
//             //     },
//             //     child: Text('press')),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfu_life_demo/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchStudentCourses();
  }

  Future<void> _fetchStudentCourses() async {
    final response = await http.get(Uri.parse(
        'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      //print("Fetched data: $data"); // Debugging line
      setState(() {
        _events = _mapCoursesToCalendar(data, 10); // Pass student_id = 10
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Map<DateTime, List<String>> _mapCoursesToCalendar(
      List<dynamic> data, int studentId) {
    final Map<DateTime, List<String>> events = {};

    final studentData = data.firstWhere((student) => student['id'] == studentId,
        orElse: () => null);

    if (studentData != null) {
      for (var course in studentData['courses']) {
        for (var schedule in course['schedules']) {
          DateTime courseDate =
              _getNextOccurrence(schedule['day'], DateTime.now());
          String courseName =
              "${course['course_name']} (${course['type']})\nClassroom: ${schedule['classroom']}\n${schedule['start_time']} - ${schedule['end_time']}";

          for (int i = 0; i < 5; i++) {
            DateTime occurrence = courseDate.add(Duration(days: 7 * i));
            // Normalize the occurrence to only include the date part
            DateTime normalizedOccurrence =
                DateTime(occurrence.year, occurrence.month, occurrence.day);
            events[normalizedOccurrence] = events[normalizedOccurrence] ?? [];
            events[normalizedOccurrence]!.add(courseName);

            // Debug print to check date mapping
            //print("Mapped event: $courseName on $normalizedOccurrence");
          }
        }
      }
    } else {
      print("Student with ID $studentId not found");
    }

    //print("Final events map: $events");
    return events;
  }

  DateTime _getNextOccurrence(String day, DateTime reference) {
    final dayOfWeekMap = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    // Check if the day exists in the map
    if (!dayOfWeekMap.containsKey(day)) {
      print("Day '$day' not found in dayOfWeekMap");
      return reference; // Return the reference date if the day is not found
    }

    int dayOfWeek = dayOfWeekMap[day]!;
    int daysToAdd = (dayOfWeek - reference.weekday) % 7;
    return reference
        .add(Duration(days: daysToAdd >= 0 ? daysToAdd : daysToAdd + 7));
  }

  List<String> _getEventsForDay(DateTime day) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    List<String> eventsForDay = _events[normalizedDay] ?? [];

    // Debug print to check events for the selected day
    //print("Events for ${normalizedDay.toLocal()}: $eventsForDay");

    return eventsForDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Courses Schedule',
          style: appbarStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7A060D),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              todayDecoration: const BoxDecoration(
                color: Color(0xFF7A060D), // Optional: Change today's color
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      _getEventsForDay(_selectedDay ?? _focusedDay)[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
