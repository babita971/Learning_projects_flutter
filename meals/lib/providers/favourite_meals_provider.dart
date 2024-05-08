// import 'package:flutter/material.dart';

// import 'meal_data_model.dart';

// class FavouriteMealsProvider extends ChangeNotifier {
//   List<Meal> _allFavouriteMeals = [];

//   get getFavouriteMeals => _allFavouriteMeals;

//   toggleFavouriteMeals(Meal meal) {
//     if (_allFavouriteMeals.contains(meal)) {
//       _allFavouriteMeals.remove(meal);
//     } else {
//       _allFavouriteMeals.add(meal);
//     }
//     notifyListeners();
//   }
// }

import 'package:meals/model/meal_data_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});

