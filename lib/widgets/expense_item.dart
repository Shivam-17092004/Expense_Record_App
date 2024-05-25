import 'package:expense_records/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expenseItem, super.key});
  final Expense expenseItem;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Text(
                  "\u20B9 ${expenseItem.amount.toStringAsFixed(2)}",
                ),
                const Spacer(),
                Icon(categoryIcons[expenseItem.category]),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat.yMd().format(expenseItem.date),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
