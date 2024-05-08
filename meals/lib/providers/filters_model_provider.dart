
import 'package:meals/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter/material.dart';

// enum MealFilters { isLactoseFree, isVegetarian, isVegan, isGlutenFree }

// class FilterMealsProvider extends ChangeNotifier {
//   Map<MealFilters, bool> _selectedMealFilters = {
//     MealFilters.isGlutenFree: false,
//     MealFilters.isLactoseFree: false,
//     MealFilters.isVegetarian: false,
//     MealFilters.isVegan: false
//   };

//   get getSelectedMealFilters => _selectedMealFilters;

//   void updateSelectedMealFilters(Map<MealFilters, bool> updatedFilters) {
//     _selectedMealFilters = updatedFilters;
//     notifyListeners();
//   }
// }


enum MealFilters { isLactoseFree, isVegetarian, isVegan, isGlutenFree }

class FiltersNotifier extends StateNotifier<Map<MealFilters, bool>> {
  FiltersNotifier()
      : super({
          MealFilters.isGlutenFree: false,
          MealFilters.isLactoseFree: false,
          MealFilters.isVegetarian: false,
          MealFilters.isVegan: false
        });

  void setFilters(Map<MealFilters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(MealFilters filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<MealFilters, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[MealFilters.isGlutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[MealFilters.isLactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[MealFilters.isVegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[MealFilters.isVegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});