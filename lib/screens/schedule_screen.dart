import 'package:flutter/material.dart';
import 'package:mooney/widgets/schedule_item.dart';
import 'tomorrow_budget_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // 스케줄 데이터 관리
  final List<Map<String, dynamic>> _schedules = [
    {'time': '5:15', 'title': '채플 시작', 'isChecked': false},
    {'time': '3:30', 'title': '3시반 영은언니/전시회', 'isChecked': true},
    {'time': '6:00', 'title': '바른학원', 'isChecked': false},
  ];

  // 체크박스 상태 변경
  void _toggleCheck(int index, bool? value) {
    setState(() {
      _schedules[index]['isChecked'] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내일의 일정'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '내일의 일정을 확인하세요',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final schedule = _schedules[index];
                return ScheduleItem(
                  time: schedule['time'],
                  title: schedule['title'],
                  isChecked: schedule['isChecked'],
                  onChanged: (value) => _toggleCheck(index, value),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed:  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TomorrowBudgetScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('완료', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

