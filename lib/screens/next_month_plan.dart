import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'new_month_budget.dart';

class NextMonthBudgetScreen extends StatefulWidget {
  const NextMonthBudgetScreen({Key? key}) : super(key: key);
  @override
  _NextMonthBudgetScreenState createState() => _NextMonthBudgetScreenState();
}

class _NextMonthBudgetScreenState extends State<NextMonthBudgetScreen> {
  double currentAmount = 100000; // 초기 금액
  final TextEditingController inputController = TextEditingController(); // 입력 필드 컨트롤러

  void adjustAmount(double adjustment) {
    setState(() {
      currentAmount += adjustment;
    });
  }
  // 완료 버튼 클릭 시 로딩 화면으로 이동
  void _handleSubmit() {
    final inputText = inputController.text.trim();
    if (inputText.isNotEmpty) {
      // 로딩 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );
    } else {
      // 텍스트가 비어있을 경우 경고
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('내용을 입력해주세요!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다음달 예산 조정'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 추가
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '이번달에는 이렇게 소비했는데,\n다음달에는 어떻게 소비하고 싶나요?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30), // 제목과 텍스트 입력 영역 간의 간격

              // 파이 차트
              PieChart(
                dataMap: {
                  '식비': 40.0,
                  '쇼핑': 30.0,
                  '교통': 20.0,
                  '문화': 10.0,
                },
                chartType: ChartType.disc,
                colorList: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                  Colors.orangeAccent,
                  Colors.purpleAccent,
                ],
                legendOptions: LegendOptions(
                  legendPosition: LegendPosition.left,
                  showLegends: true,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  chartValueBackgroundColor: Colors.transparent,
                  decimalPlaces: 1,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '현재 금액',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '₩${currentAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30), // 직사각형과 버튼 간격
              // -5만원, 유지, +5만원 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => adjustAmount(-50000),
                    child: Text('-5만원'),
                  ),
                  ElevatedButton(
                    onPressed: () {}, // 유지 버튼은 아무 동작도 하지 않음
                    child: Text('유지'),
                  ),
                  ElevatedButton(
                    onPressed: () => adjustAmount(50000),
                    child: Text('+5만원'),
                  ),
                ],
              ),
              SizedBox(height: 30), // 버튼과 입력 필드 간격
              // 입력 필드
              TextField(
                controller: inputController,
                keyboardType: TextInputType.text, // 일반 텍스트 입력 키보드
                decoration: InputDecoration(
                  labelText: '다음달 예산 설정에 특별히 반영하고 싶은 사항을 알려주세요', // 사용자 안내 텍스트 변경
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20), // 입력 필드와 버튼 사이 간격
              // 완료 버튼
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text("완료"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
//로딩화면
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewMonthBudgetScreen()),
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('로딩 화면')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로딩 인디케이터
            CircularProgressIndicator(),
            SizedBox(height: 20), // 로딩 인디케이터와 텍스트 사이의 간격
            // 텍스트 메시지
            Text(
              '화연님의 일정을 바탕으로\n다음달 예산을 짜볼게요!',
              textAlign: TextAlign.center, // 텍스트 중앙 정렬
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
