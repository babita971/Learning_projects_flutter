import 'package:flutter/material.dart';
import 'package:shopping_list/item_form.dart';
import 'package:shopping_list/models/grocery_item_model.dart';
import 'package:shopping_list/repository.dart';

import 'constants.dart';
import 'data/categories_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  bool _errorEncountered = false;
  String errorMsg = "";
  List<GroceryItem> groceryItemsList = [];
  ShoppingListRepository shoppingListRepository = ShoppingListRepository();

  @override
  void initState() {
    loadAllGroceryItems();
    super.initState();
  }

  void loadAllGroceryItems() async {
    var result = await shoppingListRepository.getAllItemsFromDatabase();
    List<GroceryItem> listData = [];
    if (result.statusCode == 200) {
      if (result.data != null) {
        for (var item in result.data.entries) {
          final category = allCategories.entries.firstWhere(
              (catItem) => catItem.value.title == item.value['category']);
          listData.add(
            GroceryItem(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category.value,
            ),
          );
        }
        setState(() {
          groceryItemsList = listData;
          _isLoading = false;
        });
      } else {
        //case when request is success but there is no data in db
        setState(() {
          // _errorEncountered = true;
          groceryItemsList = [];
          _isLoading = false;
          errorMsg = "No items added yet.";
        });
      }
    } else {
      //case when request is failed due to network issue
      setState(() {
        _errorEncountered = true;
        _isLoading = false;
        errorMsg = result.errorMsg;
      });
    }
  }

  void addNewItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const AddItemPage(),
      ),
    );

    if (newItem != null) {
      setState(() {
        groceryItemsList.add(newItem);
      });
    }
  }

  void removeItem(GroceryItem item) async {
    var result = await shoppingListRepository.removeItemFromDatabase(item.id);
    if (result.statusCode == 200) {
      setState(() {
        groceryItemsList.remove(item);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMsg),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    loadAllGroceryItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Flutter Groceries',
            style: kAppBarTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: addNewItem,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: _errorEncountered
            ? Center(
                child: Text(
                  errorMsg,
                  style: kSmallBodyTextStyle,
                  textAlign: TextAlign.center,
                ),
              )
            : _isLoading
                ? const Center(child: CircularProgressIndicator())
                : groceryItemsList.isEmpty
                    ? Center(
                        child: Text(
                          errorMsg,
                          style: kSmallBodyTextStyle,
                        ),
                      )
                    : ListView.builder(
                        itemCount: groceryItemsList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(groceryItemsList[index].id),
                            onDismissed: (direction) {
                              removeItem(groceryItemsList[index]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 0),
                              child: ListTile(
                                title: Text(
                                  groceryItemsList[index].name,
                                  style: kBodyTextStyle,
                                ),
                                leading: Container(
                                  height: 20,
                                  width: 20,
                                  color: groceryItemsList[index].category.color,
                                ),
                                trailing: Text(
                                  groceryItemsList[index].quantity.toString(),
                                  style: kBodyTextStyle,
                                ),
                              ),
                            ),
                          );
                        }),
      ),
    );
  }
}
