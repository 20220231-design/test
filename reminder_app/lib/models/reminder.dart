class Reminder {
  String title;
  String location;
  String method;
  bool notify;
  DateTime time;

  Reminder({
    required this.title,
    required this.location,
    required this.method,
    required this.notify,
    required this.time,
  });
}