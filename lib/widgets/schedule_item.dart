import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final String time;
  final String title;
  final bool isChecked;
  final Function(bool?) onChanged;

  const ScheduleItem({
    Key? key,
    required this.time,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(title, style: const TextStyle(fontSize: 16.0)),
      subtitle: Text(time, style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChanged, // 부모 위젯에서 전달된 상태 변경 함수 호출
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        side: BorderSide(color: isChecked ? Colors.purple : Colors.grey),
        checkColor: Colors.white,
        activeColor: Colors.purple,
      ),
    );
  }
}
