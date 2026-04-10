import 'package:flutter/material.dart';
import '../models/reminder.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  DateTime selected = DateTime.now();
  bool notify = false;
  String method = "Chuông";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm công việc")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: "Tên công việc"),
            ),
            TextField(
              controller: locationCtrl,
              decoration: InputDecoration(labelText: "Địa điểm"),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                DateTime? d = await showDatePicker(
                  context: context,
                  initialDate: selected,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );

                TimeOfDay? t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (d != null && t != null) {
                  selected = DateTime(
                      d.year, d.month, d.day, t.hour, t.minute);
                }
              },
              child: Text("Chọn ngày giờ"),
            ),

            SwitchListTile(
              title: Text("Nhắc việc"),
              value: notify,
              onChanged: (v) => setState(() => notify = v),
            ),

            DropdownButton<String>(
              value: method,
              items: ["Chuông", "Email", "Thông báo"]
                  .map((e) =>
                  DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => method = v!),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Reminder(
                    title: titleCtrl.text,
                    location: locationCtrl.text,
                    method: method,
                    notify: notify,
                    time: selected,
                  ),
                );
              },
              child: Text("Lưu"),
            )
          ],
        ),
      ),
    );
  }
}