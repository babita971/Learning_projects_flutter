// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:meals/providers/filters_model_provider.dart';
import 'package:meals/model/meal_data_model.dart';
import 'package:meals/screens/meals_filters.dart';
import 'package:meals/widgets/all_categories_list.dart';
import 'package:meals/widgets/drawer_widget.dart';
import 'package:meals/widgets/list_of_meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favourite_meals_provider.dart';

class MealsHomePage extends ConsumerStatefulWidget {
  const MealsHomePage({super.key});

  @override
  ConsumerState<MealsHomePage> createState() => _MealsHomePageState();
}

class _MealsHomePageState extends ConsumerState<MealsHomePage> {
  List<Meal> _allMealsList = [];
  var selectedMealFilters = {
    MealFilters.isGlutenFree: false,
    MealFilters.isLactoseFree: true,
    MealFilters.isVegetarian: false,
    MealFilters.isVegan: false
  };
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    final allAvailableMeals = ref.watch(filteredMealsProvider);
      final _allFavoriteMealsList = ref.watch(favoriteMealsProvider);
    _allMealsList = allAvailableMeals.where((meal) {
      if (!meal.isGlutenFree &&
          selectedMealFilters[MealFilters.isGlutenFree]!) {
        // If filter gluten free is true then we can't have meal that has gluten.
        // Basically meal.gluetenfree should be false.
        return false;
      }
      if (!meal.isLactoseFree &&
          selectedMealFilters[MealFilters.isLactoseFree]!) {
        return false;
      }
      if (!meal.isVegan && selectedMealFilters[MealFilters.isVegetarian]!) {
        return false;
      }
      if (!meal.isVegetarian && selectedMealFilters[MealFilters.isVegan]!) {
        return false;
      }
      return true;
    }).toList();
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // centerTitle: true, Not in iphone
            title: tabIndex == 0
                ? const Text('Categories')
                : const Text('Your Favourites'),
          ),
          drawer: BuildDrawerWidget(
            setScreen: _setScreen,
          ),
          bottomNavigationBar: TabBar(
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.category),
                text: "Categories",
              ),
              Tab(
                icon: Icon(Icons.star),
                text: "Favourites",
              ),
            ],
          ),
          body: TabBarView(
            children: [
              AllCategoriesList(mealsList: _allMealsList),
              ListOfMealsWidget(
                mealsList: _allFavoriteMealsList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setScreen(String identifier) {
    Navigator.pop(context); //remove drawer

    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const MealFiltersPage(
          ),
        ),
      );
    }
  }

  void updateFiltervariables(
    bool isGlutenFreeSelected,
    bool isLactoseFreeSelected,
    bool isVegetarianSelected,
    bool isVeganSelected,
  ) {
    // setState(() {
    //   selectedMealFilters[MealFilters.isGlutenFree] = isGlutenFreeSelected;
    //   selectedMealFilters[MealFilters.isLactoseFree] = isLactoseFreeSelected;
    //   selectedMealFilters[MealFilters.isVegetarian] = isVegetarianSelected;
    //   selectedMealFilters[MealFilters.isVegan] = isVeganSelected;
    // // });
    // Map<MealFilters, bool> result = {
    //   MealFilters.isGlutenFree: isGlutenFreeSelected,
    //   MealFilters.isLactoseFree: isLactoseFreeSelected,
    //   MealFilters.isVegetarian: isVegetarianSelected,
    //   MealFilters.isVegan: isVeganSelected
    // };


    // print(isGlutenFreeSelected);
    // print(isLactoseFreeSelected);
    // print(isVegetarianSelected);
    // print(isVeganSelected);
  }
}
