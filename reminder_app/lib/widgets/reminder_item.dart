import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderItem extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onDelete;

  ReminderItem({required this.reminder, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(reminder.title),
        subtitle: Text(
            "${reminder.time}\n${reminder.location}"),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}