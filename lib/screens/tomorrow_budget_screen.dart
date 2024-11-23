import 'package:flutter/material.dart';
import 'package:mooney/widgets/budget_item.dart';
import 'sms_screen.dart';

class TomorrowBudgetScreen extends StatelessWidget {
  const TomorrowBudgetScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      "내일 예산 11/25",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
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

                //Budget Items (List of Budget Entries)
                BudgetItemCard(
                  title: "간단한 아침, 점심",
                  amount: 10000,
                  icon: Icons.fastfood,
                ),
                BudgetItemCard(
                  title: "교통비",
                  amount: 3000,
                  icon: Icons.directions_bus,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "3:30",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                BudgetItemCard(
                  title: "전시회 입장료",
                  amount: 10000,
                  icon: Icons.card_giftcard,
                ),

                Text(
                  "총 금액: 36,500원",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
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
                  child: Text("완료", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
