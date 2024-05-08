import 'package:flutter/material.dart';
import 'package:meals/model/dummy_data.dart';
import 'package:meals/model/meal_data_model.dart';
import 'package:meals/widgets/list_of_meals.dart';

import '../model/category_model.dart';

class AllCategoriesList extends StatefulWidget {
  const AllCategoriesList({super.key, required this.mealsList});
  final List<Meal> mealsList;

  @override
  State<AllCategoriesList> createState() => _AllCategoriesListState();
}

class _AllCategoriesListState extends State<AllCategoriesList>
    with SingleTickerProviderStateMixin {
  //For single animation only
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound:
          0, //defaults. Basically between 2 values the animation animates
      upperBound: 1,
    );
    //Vsync wants a tickerProvider resposnible for animation executes for every frame 60 times/sec
    _animationController
        .forward(); //When widget is created, recreated not hidden by another widget in stack
    super.initState();
  }

  @override
  void dispose() {
    _animationController
        .dispose(); //removed when widget is removed from memory for performance
    super.dispose();
  }

  void selectCategory(
      {required BuildContext context, required Category category}) {
    // Make changes here for filtered meals here.
    var categoryMealsList = widget.mealsList
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListOfMealsWidget(
          mealsList: categoryMealsList,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("INSIDE CATEGORY  ${widget.mealsList.length}");
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
        children: [
          ...allAvailableCategories.map(
            (category) => CategoryListItem(
              category: category,
              onSelectCategory: selectCategory,
            ),
          ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
      // Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 -_animationController.value * 100,
      //   ),
      //   child: child,
      // ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem(
      {super.key, required this.category, required this.onSelectCategory});
  final Category category;
  final void Function(
      {required BuildContext context,
      required Category category}) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        onSelectCategory(context: context, category: category);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.99),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.topLeft,
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
