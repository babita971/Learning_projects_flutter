import 'dart:io';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.submitNewExpense});
  final void Function(ExpenseModel newExpense) submitNewExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _expenseTitleController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  CategoryType _selectedCategory = CategoryType.work;
  DateTime? _selectedDate;

  @override
  void dispose() {
    //Dispose all the controllers from memory when not in use.
    _expenseTitleController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      // double width = MediaQuery.of(context).size.width;
      double width = constraints.maxWidth;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20, top: 20, right: 20, bottom: keyboardSpace + 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                width > 600
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: _expenseTitleController,
                              onChanged: (value) {
                                _expenseTitleController.text = value;
                              },
                              maxLength: 50,
                              decoration: InputDecoration(
                                label: Text(
                                  'Title',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _expenseAmountController,
                              decoration: InputDecoration(
                                prefixText: "\$ ",
                                label: Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              onChanged: (value) {
                                _expenseAmountController.text = value;
                              },
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        keyboardType: TextInputType.text,
                        controller: _expenseTitleController,
                        onChanged: (value) {
                          _expenseTitleController.text = value;
                        },
                        maxLength: 50,
                        decoration: InputDecoration(
                          label: Text(
                            'Title',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                width > 600
                    ? Row(
                        children: [
                          DropdownButton(
                              value: _selectedCategory,
                              items: CategoryType.values
                                  .map(
                                    (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  
                                }
                                return;
                              }),
                          const Spacer(),
                          Text(
                            _selectedDate == null
                                ? "No date selected"
                                : formatteryMd.format(_selectedDate!),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: _showDatePicker,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _expenseAmountController,
                              decoration: InputDecoration(
                                prefixText: "\$ ",
                                label: Text(
                                  'Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              onChanged: (value) {
                                _expenseAmountController.text = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            _selectedDate == null
                                ? "No date selected"
                                : formatteryMd.format(_selectedDate!),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: _showDatePicker,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    width < 600
                        ? DropdownButton(
                            value: _selectedCategory,
                            items: CategoryType.values
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              }
                              return;
                            })
                        : const SizedBox(),
                    // DropdownMenu<CategoryType>(
                    //   initialSelection: CategoryType.work,
                    //   requestFocusOnTap: true,
                    //   onSelected: (CategoryType? category) {
                    //     setState(() {
                    //       _selectedCategory = category!;
                    //     });
                    //   },
                    //   dropdownMenuEntries: CategoryType.values
                    //       .map<DropdownMenuEntry<CategoryType>>((CategoryType value) {
                    //     return DropdownMenuEntry<CategoryType>(
                    //       value: value,
                    //       label: value.name.toUpperCase(),
                    //     );
                    //   }).toList(),
                    // ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseData();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
    ).then(
      (value) {
        setState(() {
          _selectedDate = value!;
        });
      },
    );
  }

  void _showDialogFromPlatform() {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text("Form is invalid"),
              content: const Text(
                  "Please make sure you enter correct title, amount and date."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
              title: const Text("Form is invalid"),
              content: const Text(
                  "Please make sure you enter correct title, amount and date."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Close"),
                ),
              ],
            );
          });
    }
  }

  void _submitExpenseData() {
    bool amountInvalid =
        double.tryParse(_expenseAmountController.text) == null ||
            double.tryParse(_expenseAmountController.text) == 0;
    if (_expenseTitleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      //show error message
      _showDialogFromPlatform();
      return;
    }
    ExpenseModel newExpense = ExpenseModel(
        title: _expenseTitleController.text,
        amount: num.parse(_expenseAmountController.text),
        date: _selectedDate!,
        category: _selectedCategory);
    widget.submitNewExpense(newExpense);
    Navigator.pop(context);
  }
}
