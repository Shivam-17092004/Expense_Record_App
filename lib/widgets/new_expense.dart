import 'package:expense_records/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});
  final void Function(Expense expenses) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;

  void getPickedDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  Category selectedCategory = Category.leisure;

  void showErrorMessages() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text("Please enter a vaild title, amount and date"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 30),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(label: Text("Title")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                      prefixText: "\u20B9", label: Text("Amount")),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: getPickedDate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(selectedDate != null
                        ? formatter.format(selectedDate!)
                        : "No Date selected"),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              const SizedBox(
                width: 7,
              ),
              ElevatedButton(
                onPressed: showErrorMessages,
                child: const Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
