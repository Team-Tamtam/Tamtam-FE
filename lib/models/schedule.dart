// lib/models/schedule.dart
class Schedule {
  final int scheduleId;
  final String title;
  // final int expectedExpenseAmount;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String location;

  Schedule({
    required this.scheduleId,
    required this.title,
    // required this.expectedExpenseAmount,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['scheduleId'],
      title: json['title'],
      // expectedExpenseAmount: json['expectedExpenseAmount'],
      startDateTime: DateTime.parse(json['startDateTime']),
      endDateTime: DateTime.parse(json['endDateTime']),
      location: json['location'],
    );
  }
}
