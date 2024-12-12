import 'package:flutter/material.dart';
import 'package:mooney/widgets/schedule_item.dart';
import 'tomorrow_budget_screen.dart';
import 'dart:convert'; // For jsonDecode
import 'package:http/http.dart' as http;
import 'package:mooney/models/schedule.dart';
import 'package:mooney/constants/constants.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Schedule> _schedules = [];
  List<int> _checkedIds = []; // 선택된 일정 ID 저장
  List<bool> _checkedStates = []; // 스케줄별 체크 상태를 저장하는 리스트
  bool _isLoading = false; // 로딩 상태 추가


  //api 호출(get)
  Future<void> fetchSchedules() async {
    final url = Uri.parse('$baseUrl/schedules/tomorrow');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _schedules = data.map((json) => Schedule.fromJson(json)).toList();
          _checkedStates =
              List.generate(_schedules.length, (_) => false); // 초기 상태 false
        });
      } else {
        // 서버 오류 처리
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // 네트워크 오류 처리
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  // Future<void> postSelectedSchedules(List<int> selectedIds) async {
  //   final url = Uri.parse('$baseUrl/budgets/tomorrow');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'scheduleIds': selectedIds}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       // 성공적으로 응답 받음 -> 다른 화면으로 이동
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               TomorrowBudgetScreen(responseData: responseData),
  //         ),
  //       );
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
  // api 요청(post)

  Future<void> postSelectedSchedules(List<int> selectedIds) async {
    setState(() {
      _isLoading = true; // API 호출 시작 전 로딩 활성화
    });

    final url = Uri.parse('$baseUrl/budgets/tomorrow');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'scheduleIds': selectedIds}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // 성공적으로 응답 받음 -> 다른 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TomorrowBudgetScreen(responseData: responseData),
          ),
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // 호출 완료 후 로딩 비활성화
      });
    }
  }

  // 스케줄 데이터 관리
  // final List<Map<String, dynamic>> _schedules = [
  //   {'time': '5:15', 'title': '채플 시작', 'isChecked': false},
  //   {'time': '3:30', 'title': '3시반 영은언니/전시회', 'isChecked': false},
  //   {'time': '6:00', 'title': '바른학원', 'isChecked': false},
  // ];

  // 체크박스 상태 변경
  // void _toggleCheck(int index, bool? value) {
  //   setState(() {
  //     _schedules[index]['isChecked'] = value ?? false;
  //   });
  // }
  //
  // void _toggleCheck(int index, bool? value) {
  //   setState(() {
  //     // _schedules[index]. = value ?? false;
  //     final scheduleId = _schedules[index].scheduleId;
  //
  //     if (_schedules[index].isChecked) {
  //       _checkedIds.add(scheduleId);
  //     } else {
  //       _checkedIds.remove(scheduleId);
  //     }
  //   });
  // }
  void _toggleCheck(int index, bool? value) {
    setState(() {
      _checkedStates[index] = value ?? false; // 선택 상태 업데이트
      final scheduleId = _schedules[index].scheduleId;

      if (_checkedStates[index]) {
        // 선택된 경우 ID 추가
        _checkedIds.add(scheduleId);
      } else {
        // 선택 해제된 경우 ID 제거
        _checkedIds.remove(scheduleId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내일의 일정'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '내일의 일정을 확인하신 후,\n소비가 발생할 예정인 일정을 선택해주세요!',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: _schedules.length,
              //     itemBuilder: (context, index) {
              //       final schedule = _schedules[index];
              //       return ScheduleItem(
              //         time: schedule['time'],
              //         title: schedule['title'],
              //         isChecked: schedule['isChecked'],
              //         onChanged: (value) => _toggleCheck(index, value),
              //       );
              //     },
              //   ),
              // ),

              Expanded(
                child: _schedules.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: _schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = _schedules[index];
                    return ScheduleItem(
                      time:
                      '${schedule.startDateTime.hour}:${schedule.startDateTime
                          .minute.toString().padLeft(2, '0')}',
                      // 시작 시간
                      title: schedule.title,
                      isChecked: _checkedStates[index],
                      // 초기 값
                      onChanged: (value) {
                        // 선택 상태 처리
                        _toggleCheck(index, value);
                      },
                    );
                  },
                ),
              ),


              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: ElevatedButton(
              //           onPressed: () {
              //             // Navigator.push(
              //             //   context,
              //             //   MaterialPageRoute(
              //             //     builder: (context) => const TomorrowBudgetScreen(),
              //             //   ),
              //             // );
              //             postSelectedSchedules(_checkedIds); //이거 넣고 위 지우기
              //           },
              //           style:
              //               ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              //           child:
              //               const Text('완료', style: TextStyle(color: Colors.white)),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null // 로딩 중에는 버튼 비활성화
                      : () => postSelectedSchedules(_checkedIds),
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF8E52F5)),
                  child: const Text(
                      '완료', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black45, // 배경 반투명 처리
              child: const Center(
                child: CircularProgressIndicator(), // 로딩 스피너
              ),
            ),
        ],
      ),
    );
  }
}