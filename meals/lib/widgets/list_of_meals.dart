import 'package:flutter/material.dart';
import 'package:meals/widgets/basic_meal_widget.dart';
import '../model/meal_data_model.dart';

class ListOfMealsWidget extends StatelessWidget {
  //For both category meals and favourite meals.
  const ListOfMealsWidget({
    super.key,
    this.title,
    required this.mealsList,
  });
  final String? title;
  final List<Meal> mealsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
      body: mealsList.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No meals for this category",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Try selecting a different category",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView(
              children: mealsList
                  .map(
                    (meal) => BasicMealWidget(
                      meal: meal,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
