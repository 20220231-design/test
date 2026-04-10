import 'package:flutter/material.dart';
import '../models/reminder.dart';
import 'add_screen.dart';
import '../widgets/reminder_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reminder> list = [];

  void addReminder(Reminder r) {
    setState(() {
      list.add(r);
    });
  }

  void deleteReminder(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhắc việc"),
        centerTitle: true,
      ),
      body: list.isEmpty
          ? Center(child: Text("Chưa có công việc"))
          : ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) => ReminderItem(
          reminder: list[i],
          onDelete: () => deleteReminder(i),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddScreen()),
          );
          if (result != null) addReminder(result);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}