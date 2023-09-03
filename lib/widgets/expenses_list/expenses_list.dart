import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onDeleteExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expenses[index].id),
        onDismissed: (direction) {
          onDeleteExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
