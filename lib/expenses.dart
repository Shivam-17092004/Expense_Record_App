import 'package:expense_records/models/expense.dart';
import 'package:expense_records/widgets/chart.dart';
import 'package:expense_records/widgets/expense_list.dart';
import 'package:expense_records/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpense = [];

  void openModalOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: addingNewExpense,
          );
        });
  }

  void addingNewExpense(Expense expenses) {
    setState(() {
      registeredExpense.add(expenses);
    });
  }

  void onRemoveExpense(Expense delExpense) {
    final myIndex = registeredExpense.indexOf(delExpense);
    setState(() {
      registeredExpense.remove(delExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredExpense.insert(myIndex, delExpense);
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text("No expense found. Start adding some!"),
    );

    if (registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenseList: registeredExpense,
        onRemoveExpense: onRemoveExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),
          actions: [
            IconButton(
              onPressed: openModalOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Chart(expenses: registeredExpense)),
            Expanded(child: mainContent),
          ],
        ));
  }
}
