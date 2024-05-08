// import 'package:expense_tracker/expense/chart/chart.dart';
import 'package:expense_tracker/expense/chart/custom_bar_chart.dart';
import 'package:expense_tracker/expense/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

import 'expense_form.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  //Dummy Data
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
        title: "Flutter",
        amount: 20,
        date: DateTime.now(),
        category: CategoryType.work),
    ExpenseModel(
        title: "Groceries",
        amount: 30,
        date: DateTime.now(),
        category: CategoryType.food),
    ExpenseModel(
        title: "Camera",
        amount: 520,
        date: DateTime.now(),
        category: CategoryType.travel),
    ExpenseModel(
        title: "Movies",
        amount: 60,
        date: DateTime.now(),
        category: CategoryType.leisure),
  ];

  double get totalSumOfAllExpenses {
    double result = 0;
    for (var expense in _registeredExpenses) {
      result += expense.amount;
    }
    return result;
  }

  void addNewExpenseToList(ExpenseModel newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void removeExpenseFromList(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense deleted!"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _showAddExpenseDialog() {
    showModalBottomSheet(
        useSafeArea: true,
        isDismissible: true,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
        ),
        context:
            context, // When you're in a class that extends State, flutter automatically adds context property to it behind the scenes.
        builder: (BuildContext ctx) {
          // Context of modal sheet
          return ExpenseForm(submitNewExpense: addNewExpenseToList);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      // top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // backgroundColor: const Color.fromARGB(255, 96, 59, 181),
          title: const Text(
            "Flutter Expense Tracker",
            textAlign: TextAlign.center,
            // style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: _showAddExpenseDialog,
              icon: const Icon(
                Icons.add,
              ),
              // color: Colors.white,
            ),
          ],
        ),
        body: _registeredExpenses.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "No expenses at the moment. Start adding some.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            : width < 600
                ? Column(
                    children: [
                      // Chart(expenses: _registeredExpenses), //Course
                      // const Expanded(
                      //   child: FlBarChart(), //Fl Chart
                      // ),
                      CustomBarChart(
                          allRegisteredExpenses: _registeredExpenses,
                          totalSumOfExpenses: totalSumOfAllExpenses),
                      Expanded(
                        child: ExpensesList(
                          expensesList: _registeredExpenses,
                          removeExpense: removeExpenseFromList,
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      // Chart(expenses: _registeredExpenses), //Course
                      // const Expanded(
                      //   child: FlBarChart(), //Fl Chart
                      // ),
                      CustomBarChart(
                          allRegisteredExpenses: _registeredExpenses,
                          totalSumOfExpenses: totalSumOfAllExpenses),
                      Expanded(
                        child: ExpensesList(
                          expensesList: _registeredExpenses,
                          removeExpense: removeExpenseFromList,
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
