import 'package:flutter/material.dart';
import 'next_month_plan.dart';
import 'package:mooney/widgets/budget_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mooney/constants/constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Map<String, dynamic>? responseData; // API 응답 데이터를 저장
  bool isLoading = true; // 로딩 상태

  @override
  void initState() {
    super.initState();
    fetchMonthlyReport(); // 화면 초기화 시 데이터 가져오기
  }

  // API 호출 함수
  Future<void> fetchMonthlyReport() async {
    const String url = '$baseUrl/reports/monthly?year=2024&month=12';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          responseData = json.decode(response.body); // JSON 응답 데이터 파싱
          isLoading = false; // 로딩 상태 종료
        });
      } else {
        throw Exception('Failed to load monthly report');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // 에러 시 로딩 상태 종료
      });
      print('Error fetching data: $e');
    }
  }

  // 임시 데이터
  final List<Map<String, dynamic>> categoryData = [
    {'category': '패션/쇼핑', 'percent': 125},
    {'category': '교육/학습', 'percent': 70},
    {'category': '문화/여가', 'percent': 110},
    {'category': '카페/간식', 'percent': 105},
    {'category': '교통', 'percent': 90},
    {'category': '식비', 'percent': 102},
    {'category': '생활', 'percent': 30},
    {'category': '뷰티/미용', 'percent': 30},
    {'category': '의료/건강', 'percent': 104},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이번달 소비 피드백'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이번달 소비 피드백',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '카테고리별 예산 결과',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              // GridView로 2개씩 렌더링
              GridView.builder(
                shrinkWrap: true,
                // GridView가 필요한 만큼만 공간을 차지하게 설정
                physics: NeverScrollableScrollPhysics(),
                // 부모 스크롤로만 스크롤
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 두 개씩 배치
                  crossAxisSpacing: 13, // 가로 간격
                  mainAxisSpacing: 13, // 세로 간격
                ),
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  return BudgetCard(
                    category: categoryData[index]['category'],
                    percent: categoryData[index]['percent'],
                  );
                },
              ),
              SizedBox(height: 20), // GridView와 텍스트 간의 간격
              Text(
                '무니의 피드백',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                // 텍스트와 경계 간격
                decoration: BoxDecoration(
                  color: Color(0xFFEAD9FF), // 연보라색 배경
                  borderRadius: BorderRadius.circular(8), // 모서리를 둥글게
                ),
                child: isLoading
                    ? Center(child: CircularProgressIndicator()) // 로딩 중일 때
                    : Text(
                  responseData?['feedbackMessage'] ??
                      '피드백 메시지가 없습니다.',
                  // 여기에 API 응답 데이터로 넣고 싶은 텍스트
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //    child : Text(
                //       '피드백 메시지가 없습니다.',
                //   // 여기에 API 응답 데이터로 넣고 싶은 텍스트
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
              SizedBox(height: 20),
              // "다음달 예산 짜러가기" 버튼 추가
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NextMonthBudgetScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF8E52F5), // 버튼 색상
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  '다음달 예산 짜러가기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
