import 'package:flutter/material.dart';
import 'next_month_plan.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 임시 데이터
    final List<Map<String, dynamic>> categoryData = [
      {'category': '식비', 'percent': 125},
      {'category': '쇼핑', 'percent': 70},
      {'category': '교통', 'percent': 110},
      {'category': '문화', 'percent': 90},
    ];

    return Scaffold(
        appBar: AppBar(

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
                    crossAxisCount: 2, // 한 줄에 두 개씩 배치
                    crossAxisSpacing: 16, // 가로 간격
                    mainAxisSpacing: 16, // 세로 간격
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
                  '무늬의 피드백',
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
                  child: Text(
                    '이번 달 식비를 정말 잘 절약하셨어요! 🎉 하지만 외식비가 살짝 늘어났네요. 다음 달에는 외식 횟수를 조금 줄이고 대신 식비 예산을 살짝 늘려서 균형을 맞춰보는 건 어떨까요? 이렇게 하면 더 많은 저축도 가능할 거예요! 😊',
                    // 여기에 넣고 싶은 텍스트
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    backgroundColor: Colors.deepPurple,  // 버튼 색상
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
        ));
  }
}

class BudgetCard extends StatelessWidget {
  final String category;
  final int percent;

  BudgetCard({required this.category, required this.percent});

  @override
  Widget build(BuildContext context) {
    // 배경색 결정
    Color backgroundColor = percent <= 100 ? Colors.lightGreen : Colors.red;

    return AspectRatio(
      aspectRatio: 2 / 1, // 가로가 세로의 2배 크기 (세로가 짧은 직사각형)
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12), // 직사각형의 모서리를 둥글게
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$percent%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
