import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseListitem extends StatelessWidget {
  const ExpenseListitem({super.key, required this.expense});
  final ExpenseModel expense;

  // More efficient to use map/objects instaed of functions that will run everytime.
  // IconData getIconType(CategoryType category) {
  //   switch (category) {
  //     case CategoryType.food:
  //       return Icons.lunch_dining;

  //     case CategoryType.leisure:
  //       return Icons.movie;

  //     case CategoryType.travel:
  //       return Icons.flight_takeoff;

  //     case CategoryType.work:
  //       return Icons.work;

  //     default:
  //       return Icons.miscellaneous_services;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Icon(
                    categoryIconsType[expense.category],
                    size: 28,
                  ),
                ),
                Text(
                  expense.formattedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
