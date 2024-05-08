import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CategoryType { food, leisure, work, travel }

const uuid = Uuid();
final DateFormat formatteryMd = DateFormat.yMd();

final categoryIconsType = {
  CategoryType.food: Icons.lunch_dining,
  CategoryType.leisure: Icons.movie,
  CategoryType.travel: Icons.flight_takeoff,
  CategoryType.work: Icons.work,
};

class ExpenseModel {
  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final num amount;
  final DateTime date;
  final CategoryType category;

  String get formattedDate {
    return formatteryMd.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.allExpenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : allExpenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final CategoryType category;
  final List<ExpenseModel> allExpenses;

  double get getTotalExpensesOfBucket {
    double sum = 0;
    for (final expense in allExpenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
