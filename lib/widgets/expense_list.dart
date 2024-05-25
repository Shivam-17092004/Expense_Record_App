import 'package:expense_records/models/expense.dart';
import 'package:expense_records/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {required this.expenseList, required this.onRemoveExpense, super.key});
  final List<Expense> expenseList;
  final void Function(Expense delExpense) onRemoveExpense;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (ctx, indx) {
        return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.errorContainer,
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenseList[indx]),
            onDismissed: (direction) => onRemoveExpense(expenseList[indx]),
            child: ExpenseItem(expenseItem: expenseList[indx]));
      },
    );
  }
}
