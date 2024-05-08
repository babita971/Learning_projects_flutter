import 'package:expense_tracker/expense/expense_list_item.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.removeExpense});
  final List<ExpenseModel> expensesList;
  final void Function(ExpenseModel expense) removeExpense;

  //  More efficient to use map of enum than computing switch case everytime
  // IconData getIconType(CategoryType category) {
  //   switch (category) {
  //     case CategoryType.food:
  //       return Icons.fastfood;

  //     case CategoryType.leisure:
  //       return Icons.personal_video_sharp;

  //     case CategoryType.travel:
  //       return Icons.mode_of_travel_outlined;

  //     case CategoryType.work:
  //       return Icons.work;

  //     default:
  //       return Icons.miscellaneous_services;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //Use when you don't want to create items that are all visible at the same time but gets created on scrolling.
      itemCount: expensesList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expensesList[index]),
          // ignore: prefer_const_constconst ructors
          background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: const EdgeInsets.symmetric(horizontal: 20)),
          onDismissed: (DismissDirection direction) {
            removeExpense(expensesList[index]);
          },
          child: ExpenseListitem(
            expense: expensesList[index],
          ),
        );
      },
    );
  }
}
