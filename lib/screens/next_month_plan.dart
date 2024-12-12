import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'new_month_budget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mooney/constants/constants.dart';

//연말이라 약속이 많아질 예정이니, 식비를 좀 늘려줘!

class NextMonthBudgetScreen extends StatefulWidget {
  const NextMonthBudgetScreen({Key? key}) : super(key: key);
  @override
  _NextMonthBudgetScreenState createState() => _NextMonthBudgetScreenState();
}

class _NextMonthBudgetScreenState extends State<NextMonthBudgetScreen> {
  double currentAmount = 0; // 초기 금액
  final TextEditingController inputController = TextEditingController(); // 입력 필드 컨트롤러
  bool isLoading = true; // 로딩 상태
  Map<String, double> categoryData = {}; // 카테고리 데이터를 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchData(); // 데이터 가져오기
  }


  // api : 파이차트 데이터 호출(post)
  Future<void> _fetchData() async {
    final response = await http.post(Uri.parse('$baseUrl/reports/categories?year=2024&month=12'));

    if (response.statusCode == 200) {
      // List<dynamic> data = jsonDecode(response.body);
      final data = jsonDecode(response.body);

      // API 응답 데이터를 categoryData에 맞게 변환

      // budgetAmount를 현재 금액으로 설정
      final double budgetAmount = (data['budgetAmount'] as num).toDouble();

      // categories 데이터를 처리
      final List<dynamic> categories = data['categories'];
      Map<String, double> dataMap = {};
      for (var item in categories) {
        final String categoryName = item['categoryName'];
        final double percentage = (item['percentage'] as num).toDouble();
        dataMap[categoryName] = percentage;
      }

      setState(() {
        currentAmount = budgetAmount;
        categoryData = dataMap; // 파이 차트에 사용할 데이터 설정
        isLoading = false; // 로딩 완료
      });
    } else {
      // API 호출 실패 처리
      throw Exception('Failed to load data');
    }
  }

  //api 호출(post)
  Future<void> _submitData(String message) async {
    final url = '$baseUrl/budgets/next-month';
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"budgetAmount" : currentAmount,"message": message});
    // try {
    //   // API 호출
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: headers,
    //     body: body,
    //   );
    //   debugPrint("응답: "+response.body);
    //   final data = jsonDecode(response.body);
    //
    //   // 응답 후 로딩 화면으로 이동
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoadingScreen(responseData: data),
    //     ),
    //   );
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('네트워크 오류')),
    //   );
    // }
    try {
      // 요청 전 로딩 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(apiCall: http.post(
            Uri.parse(url),
            headers: headers,
            body: body,
          )),
        ),
      );
    } catch (error) {
      // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네트워크 오류')),
      );
    }
  }


  void adjustAmount(double adjustment) {
    setState(() {
      currentAmount += adjustment;
    });
  }
  // 완료 버튼 클릭 시 로딩 화면으로 이동
  void _handleSubmit() {
    final inputText = inputController.text.trim();
    if (inputText.isNotEmpty) {
      _submitData(inputText);

    } else {
      // 텍스트가 비어있을 경우 경고
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('내용을 입력해주세요!')),
      );
    }
  //   if (inputText.isNotEmpty) {
  //     // API 호출
  //     _submitData(inputText);
  //     // 로딩 화면으로 이동
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoadingScreen()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('내용을 입력해주세요!')),
  //     );
  //   }
  // },
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
              // PieChart(
              //   dataMap: {
              //     '식비': 30.0,
              //     '문화/여가': 10.0,
              //     '쇼핑': 20.0,
              //     '카페/간식': 15.0,
              //     '뷰티/미용' : 10.0,
              //     '의료/건강' : 15.0,
              //   },
              //   chartType: ChartType.disc,
              //   colorList: [
              //     Colors.blueAccent,
              //     Colors.lightBlueAccent,
              //     Colors.orangeAccent,
              //     Colors.purpleAccent,
              //     Colors.lightGreenAccent,
              //     Colors.yellowAccent
              //   ],
              //   legendOptions: LegendOptions(
              //     legendPosition: LegendPosition.left,
              //     showLegends: true,
              //   ),
              //   chartValuesOptions: ChartValuesOptions(
              //     showChartValues: true,
              //     showChartValuesInPercentage: true,
              //     chartValueBackgroundColor: Colors.transparent,
              //     decimalPlaces: 1,
              //   ),
              //),
              // 로딩 중이면 로딩 화면을 표시
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PieChart(
                dataMap: categoryData,
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
              SizedBox(height:15),

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
// //로딩화면
// class LoadingScreen extends StatelessWidget {
//   // final String responseData;
//   //
//   // LoadingScreen({required this.responseData});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => NewMonthBudgetScreen()),
//       );
//     });
//
//     return Scaffold(
//       appBar: AppBar(title: Text('로딩 화면')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // 로딩 인디케이터
//             CircularProgressIndicator(),
//             SizedBox(height: 20), // 로딩 인디케이터와 텍스트 사이의 간격
//             // 텍스트 메시지
//             Text(
//               '화연님의 일정을 바탕으로\n다음달 예산을 짜볼게요!',
//               textAlign: TextAlign.center, // 텍스트 중앙 정렬
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoadingScreen extends StatefulWidget {
  final Future<http.Response> apiCall; // API 호출 Future

  LoadingScreen({required this.apiCall});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _handleApiCall();
  }

  Future<void> _handleApiCall() async {
    try {
      // API 응답 기다림
      final response = await widget.apiCall;
      final responseData = jsonDecode(response.body);

      // 응답 처리 후 다음 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewMonthBudgetScreen(apiResponse: responseData),
        ),
      );
    } catch (error) {
      // 네트워크 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네트워크 오류')),
      );

      // 네트워크 오류 발생 시 이전 화면으로 돌아가기
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로딩 화면')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              '화연님의 일정을 바탕으로\n다음달 예산을 짜볼게요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
