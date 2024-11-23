import 'package:flutter/material.dart';
class BudgetItemCard extends StatelessWidget {
  final String title;
  final int amount;
  final IconData icon;

  const BudgetItemCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      elevation: 4,
      child: SizedBox(
        height: 80,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.teal),
              SizedBox(width: 12),// Space between icon and text
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),

                    Text('${amount}원', style: TextStyle(color: Colors.teal)),
                  ],
                ),
              ),
              SizedBox(width: 3),
              Icon(Icons.edit, color: Colors.teal),
            ],
          ),
        ),
      ),
    );
  }
}
