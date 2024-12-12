import 'package:flutter/material.dart';


class NewMonthBudgetScreen extends StatelessWidget {
  final apiResponse; // API 응답 데이터

  //식비를 줄일래
  // NewMonthBudgetScreen({required this.apiResponse});
  const NewMonthBudgetScreen({Key? key, required this.apiResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // API 응답에서 totalAmount, categories, keySchedules를 추출
    final totalAmount = apiResponse['budgetAmount'].toInt();
    final List categories = apiResponse['categories'];
    final List keySchedules = apiResponse['keySchedules'];
    final reason = apiResponse['reason'];

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(0xFF8E52F5),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목: "다음달 예산"
                // Text(
                //   '다음달 예산',
                //   style: TextStyle(
                //     fontSize: 28,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // 제목: "다음달 예산"
                Row(
                  children: [
                    Text(
                      '다음달 예산',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Color(0xFF8E52F5),
                      ),
                      onPressed: () {
                        // 모달 띄우기
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Color(0xFFF0E9FF), // 연보라색
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            content: SingleChildScrollView(
                            child : Text(
                              reason,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  '닫기',
                                  style: TextStyle(color: Color(0xFF8E52F5)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20), // 제목과 소제목 간 간격

                // 총 예산
                Center(
                  child: Text(
                    '총 예산 : ${totalAmount}원',
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

                // 카테고리별 예산 직사각형 (카테고리별 예산 리스트)
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return BudgetCard(
                      category: categories[index]['categoryName'],
                      amount:
                          (categories[index]['categoryBudgetAmount'].toInt()),
                      // 문자열을 정수로 변환
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

                // 주요 일정 리스트
                SizedBox(height: 10),
                Column(
                  children: keySchedules.map<Widget>((schedule) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF8E52F5), // 배경색
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        '${schedule['title']}(${schedule['startDateTime']})',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}

class BudgetCard extends StatelessWidget {
  final String category;
  final amount;

  BudgetCard({required this.category, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // 카드 그림자 효과
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // 카드 모서리 둥글게
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // 카테고리와 금액 간 간격
            Text(
              '${amount}원',
              style: TextStyle(
                fontSize: 16,
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
