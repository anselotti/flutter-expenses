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
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlayModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} poistettu'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Peruuta',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding expenses!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onDeleteExpense: _deleteExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kululaskuri'),
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
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
