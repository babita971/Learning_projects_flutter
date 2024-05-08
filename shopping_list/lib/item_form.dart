import 'package:flutter/material.dart';
import 'package:shopping_list/constants.dart';
import 'package:shopping_list/data/categories_data.dart';

import 'models/grocery_item_model.dart';
import 'repository.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final formKey = GlobalKey<FormState>();
  bool isSubmitting = false;
  var selectedName = "";
  var selectedQuantity = 0;
  var selectedCategory = allCategories[Categories.vegetables];
  ShoppingListRepository shoppingListRepository = ShoppingListRepository();

  void submitForm() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter correct values"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      formKey.currentState!.save();
      setState(() {
        isSubmitting = true;
      });
      shoppingListRepository.addItemToDataBase(
        body: {
          "name": selectedName,
          "quantity": selectedQuantity,
          "category": selectedCategory!.title,
        },
      ).then((result) {
        isSubmitting = false;
        if (result.statusCode != 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Oops. Network error has been occured."),
              duration: Duration(seconds: 3),
            ),
          );
        }
        Navigator.of(context).pop(
          GroceryItem(
              id: result.data['name'],
              name: selectedName,
              quantity: selectedQuantity,
              category: selectedCategory!),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add new item",
          style: kAppBarTextStyle,
        ),
        centerTitle: false,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  // label: Text("Enter item name"),
                  hintText: "Enter valid item name",
                ),
                maxLength: 10,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return "Item name cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  selectedName = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        // label: Text("Enter item name"),
                        hintText: "Enter item quantity",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Item quantity cannot be empty";
                        } else if (int.tryParse(value)! <= 0) {
                          return "Invalid item quantity";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        selectedQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  // const Text("Select category"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: allCategories.entries
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    color: category.value.color,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  )
                  // DropdownButton(
                  //   value: inititalCategory,
                  //   items: Categories.values
                  //       .map(
                  //         (category) => DropdownMenuItem(
                  //           value: category,
                  //           child: Text(category.name),
                  //         ),
                  //       )
                  //       .toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       inititalCategory = value!;
                  //     });
                  //   },
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            formKey.currentState!.reset();
                          },
                    child: const Text("Reset"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: isSubmitting ? null : submitForm,
                    child: isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Add item"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
