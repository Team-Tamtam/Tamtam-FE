import 'package:flutter/material.dart';

class NewMonthBudgetScreen extends StatelessWidget {
  const NewMonthBudgetScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 카테고리와 예산 데이터 (임시 데이터)
    final List<Map<String, dynamic>> categoryData = [
      {'category': '식비', 'amount': 200000},
      {'category': '쇼핑', 'amount': 150000},
      {'category': '교통', 'amount': 100000},
      {'category': '문화', 'amount': 50000},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF8E52F5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목: "다음달 예산"
            Text(
              '다음달 예산',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // 제목과 소제목 간 간격

            Center(
              child: Text(
                '총 예산 : 1,000,000원',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20), // 소제목과 다음 텍스트 간 간격

            // 카테고리별 예산 텍스트
            Text(
              '다음달 카테고리별 예산',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 카테고리별 예산 직사각형
            // 카테고리별 예산 직사각형
            GridView.builder(
              shrinkWrap: true, // GridView가 필요한 만큼만 공간을 차지하게 설정
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 두 개씩 배치
                crossAxisSpacing: 16, // 가로 간격
                mainAxisSpacing: 16, // 세로 간격
              ),
              itemCount: categoryData.length,
              itemBuilder: (context, index) {
                return BudgetCard(
                  category: categoryData[index]['category'],
                  amount: categoryData[index]['amount'],
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              '다음달 주요 일정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              // 화면 가로 전체
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF8E52F5), // 배경색
                borderRadius: BorderRadius.circular(16.0), // 둥근 모서리
              ),
              child: Text(
                '여행(2024.10.21 ~ 2024.10.24)',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // 텍스트 색상
                ),
                textAlign: TextAlign.center, // 텍스트 가로 중앙 정렬
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  final String category;
  final int amount;

  BudgetCard({required this.category, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // 카드 그림자 효과
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // 카드 모서리 둥글게
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // 카테고리와 금액 간 간격
            Text(
              '${amount}원',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
