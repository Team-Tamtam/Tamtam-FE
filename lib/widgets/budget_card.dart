import 'package:flutter/material.dart';
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
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}