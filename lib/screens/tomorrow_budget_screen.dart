import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mooney/widgets/budget_item.dart';
import 'sms_screen.dart';

class TomorrowBudgetScreen extends StatelessWidget {
  // const TomorrowBudgetScreen({Key? key}) : super(key: key);
  final Map<String, dynamic> responseData; // 응답 데이터

  const TomorrowBudgetScreen({Key? key, required this.responseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalAmount = responseData['budgetAmount'] ?? 0; // 응답 데이터에서 금액 추출
    final List<dynamic> repeatedSchedules =
        responseData['repeatedSchedules'] ?? [];
    final List<dynamic> tomorrowSchedules =
        responseData['tomorrowSchedules'] ?? [];
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Date
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "내일의 예산",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Left-aligned text for "반복 지출"
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "반복 지출",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),

                // const SizedBox(height: 16),
                Column(
                  children: repeatedSchedules.map((schedule) {
                    return BudgetItemCard(
                      title: schedule['title'] ?? '제목 없음',
                      amount: schedule['predictedAmount'] ?? 0,
                      icon: Icons.repeat, // 반복 지출 아이콘
                    );
                  }).toList(),
                ),

                //Budget Items (List of Budget Entries)
                // BudgetItemCard(
                //   title: "간단한 아침, 점심",
                //   amount: 10000,
                //   icon: Icons.fastfood,
                // ),
                // BudgetItemCard(
                //   title: "교통비",
                //   amount: 3000,
                //   icon: Icons.directions_bus,
                // ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "내일의 일정",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                Column(
                  children: tomorrowSchedules.map((schedule) {
                    return BudgetItemCard(
                      title: schedule['title'] ?? '제목 없음',
                      amount: schedule['predictedAmount'] ?? 0,
                      icon: Icons.event, // 일정 아이콘
                    );
                  }).toList(),
                ),
                // BudgetItemCard(
                //   title: "전시회 입장료",
                //   amount: 10000,
                //   icon: Icons.card_giftcard,
                // ),

                // Text(
                //   "총 금액: 36,500원",
                //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                // ),
                SizedBox(height : 40),
                Text(
                  "총 금액: ${totalAmount.toInt()}원",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SmsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor:  Color(0xFF8E52F5)),
                  child: Text("완료", style: TextStyle(color:Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
