import 'package:flutter/material.dart';
import 'package:meals/providers/favourite_meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/meal_data_model.dart';

class MealDetails extends ConsumerStatefulWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;
  @override
  ConsumerState<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends ConsumerState<MealDetails> {
  void updateMealFavouriteProperty() {
    setState(() {
      final wasAdded = ref
          .read(favoriteMealsProvider.notifier)
          .toggleMealFavoriteStatus(widget.meal);
      widget.meal.isFavourite = wasAdded;
      ScaffoldMessenger.of(context).clearSnackBars();
      if (wasAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Meal is added to favourites!"),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Meal is no longer a favourite!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: updateMealFavouriteProperty,
            icon: AnimatedSwitcher(
              //Implicit animation
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(
                    //More the differene, more wild/strong the animation
                    begin: 0.9,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                widget.meal.isFavourite ? Icons.star : Icons.star_outline,
                key: ValueKey(
                  widget.meal.isFavourite,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.meal
                  .id, //Give same tag for hero to differentiate, child widget do not matter
              child: Image.network(
                widget.meal.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Ingredients",
                style: Theme.of(context).textTheme.headlineMedium!),
            const SizedBox(
              height: 14,
            ),
            ...widget.meal.ingredients.map(
              (element) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 5.0, left: 14, right: 14),
                child: Text(
                  element,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text("Steps", style: Theme.of(context).textTheme.headlineMedium!),
            const SizedBox(
              height: 10,
            ),
            ...widget.meal.steps.map(
              (element) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 14, right: 14),
                child: Text(
                  element,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
