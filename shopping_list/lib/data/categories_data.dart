import 'package:flutter/material.dart';

import '../models/category_model.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  sweets,
  carbs,
  spices,
  convenience,
  hygiene,
  other
}

// Map of Categories enum and Category Model
final allCategories = {
  Categories.vegetables: Category(
    title: 'Vegetables',
    color: const Color.fromARGB(255, 37, 212, 124),
  ),
  Categories.fruit: Category(
    title: 'Fruit',
    color: const Color.fromARGB(255, 239, 9, 9),
  ),
  Categories.meat: Category(
    title: 'Meat',
    color: const Color.fromARGB(255, 236, 65, 216),
  ),
  Categories.dairy: Category(
    title: 'Dairy',
    color: const Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: Category(
    title: 'Carbs',
    color: const Color.fromARGB(255, 200, 236, 154),
  ),
  Categories.sweets: Category(
    title: 'Sweets',
    color: const Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: Category(
    title: 'Spices',
    color: const Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: Category(
    title: 'Convenience',
    color: const Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    title: 'Hygiene',
    color: const Color.fromARGB(255, 213, 228, 52),
  ),
  Categories.other: Category(
    title: 'Other',
    color: const Color.fromARGB(255, 0, 225, 255),
  ),
};
