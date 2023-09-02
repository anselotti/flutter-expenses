import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Hockey Match',
        amount: 25,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Big Mac',
        amount: 11.50,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Slovenia Trip',
        amount: 512,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpenseOverlayModal() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const NewExpense();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlayModal,
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(
            child: ExpenseList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
