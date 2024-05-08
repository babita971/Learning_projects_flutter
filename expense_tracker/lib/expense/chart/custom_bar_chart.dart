import 'package:flutter/material.dart';

import '../../models/expense_model.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart(
      {super.key, required this.allRegisteredExpenses, required this.totalSumOfExpenses});
  final List<ExpenseModel> allRegisteredExpenses;
  final double totalSumOfExpenses;

  List<ExpenseBucket> get allExpenseBuckets {
    return [
      ExpenseBucket.forCategory(allRegisteredExpenses, CategoryType.work),
      ExpenseBucket.forCategory(allRegisteredExpenses, CategoryType.food),
      ExpenseBucket.forCategory(allRegisteredExpenses, CategoryType.leisure),
      ExpenseBucket.forCategory(allRegisteredExpenses, CategoryType.travel),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // double totalExpenses = 0.0;
    //What do I need. Total expense of each buckets. Total expense of all buckets.

    // for (var expenseBucket in allExpenseBuckets) {
    //   for (var expense in expenseBucket.allExpenses) {
    //     totalExpenses += expense.amount;
    //   }
    // }
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: allExpenseBuckets
                      .map(
                        (bucket) => Container(
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: (bucket.getTotalExpensesOfBucket /
                                totalSumOfExpenses),
                          ),
                        ),
                      )
                      .toList()),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...allExpenseBuckets.map(
                  (expense) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    width: 80,
                    child: Icon(
                      categoryIconsType[expense.category],
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
