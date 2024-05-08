// Meal(
//     id: 'm1',
//     categories: [
//       'c1',
//       'c2',
//     ],
//     title: 'Spaghetti with Tomato Sauce',
//     affordability: Affordability.affordable,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
//     duration: 20,
//     ingredients: [
//       '4 Tomatoes',
//       '1 Tablespoon of Olive Oil',
//       '1 Onion',
//       '250g Spaghetti',
//       'Spices',
//       'Cheese (optional)'
//     ],
//     steps: [
//       'Cut the tomatoes and the onion into small pieces.',
//       'Boil some water - add salt to it once it boils.',
//       'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
//       'In the meantime, heaten up some olive oil and add the cut onion.',
//       'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
//       'The sauce will be done once the spaghetti are.',
//       'Feel free to add some cheese on top of the finished dish.'
//     ],
//     isGlutenFree: false,
//     isVegan: true,
//     isVegetarian: true,
//     isLactoseFree: true,
//   ),

enum Affordability { affordable, pricey, luxurious }

enum Complexity { simple, challenging, hard }


class Meal {
  Meal({
    required this.id,
    required this.title,
    required this.categories,
    required this.affordability,
    required this.complexity,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
  }) : isFavourite = false;

  final String id;
  final String title;
  final List<String> categories;
  final Affordability affordability;
  final Complexity complexity;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  bool isFavourite;
}
