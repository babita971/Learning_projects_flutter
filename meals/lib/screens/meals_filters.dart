import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_model_provider.dart';
// import 'package:meals/widgets/drawer_dart';

class MealFiltersPage extends ConsumerWidget {//Change stateful to consumer(stles) cause now we won't be using local state changes
  const MealFiltersPage({
    super.key,
  });

  // bool isGlutenFreeSelected = false;
  // bool isLactoseFreeSelected = false;
  // bool isVegetarianSelected = false;
  // bool isVeganSelected = false;

  // @override
  // void initState() {
  //   isGlutenFreeSelected = widget.currentFilters[MealFilters.isGlutenFree]!;
  //   isLactoseFreeSelected = widget.currentFilters[MealFilters.isLactoseFree]!;
  //   isVegetarianSelected = widget.currentFilters[MealFilters.isVegetarian]!;
  //   isVeganSelected = widget.currentFilters[MealFilters.isVegan]!;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        centerTitle: false,
      ),
      // drawer: BuildDrawerWidget(
      //   setScreen: _setScreen,
      // ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[MealFilters.isGlutenFree]!,
            title: Text(
              "Gluten-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: Text(
              "Only include gluten-free meals.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(MealFilters.isGlutenFree, value);
              // isGlutenFreeSelected = value;
              // setState(() {
              //   widget.updateFilters(
              //       isGlutenFreeSelected,
              //       isLactoseFreeSelected,
              //       isVegetarianSelected,
              //       isVeganSelected);
              // });
            },
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SwitchListTile(
            value: activeFilters[MealFilters.isLactoseFree]!,
            title: Text(
              "Lactose-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: Text(
              "Only include lactose-free meals.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(MealFilters.isLactoseFree, value);
              // isLactoseFreeSelected = value;
              // setState(() {
              //   widget.updateFilters(
              //       isGlutenFreeSelected,
              //       isLactoseFreeSelected,
              //       isVegetarianSelected,
              //       isVeganSelected);
              // });
            },
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SwitchListTile(
            value: activeFilters[MealFilters.isVegetarian]!,
            title: Text(
              "Vegetarian",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: Text(
              "Only include vegetarian meals.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(MealFilters.isVegetarian, value);
              // isVegetarianSelected = value;
              // setState(() {
              //   widget.updateFilters(
              //       isGlutenFreeSelected,
              //       isLactoseFreeSelected,
              //       isVegetarianSelected,
              //       isVeganSelected);
              // });
            },
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SwitchListTile(
            value: activeFilters[MealFilters.isVegan]!,
            title: Text(
              "Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: Text(
              "Only include vegan meals.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(MealFilters.isVegan, value);
              // isVeganSelected = value;
              // setState(() {
              //   widget.updateFilters(
              //       isGlutenFreeSelected,
              //       isLactoseFreeSelected,
              //       isVegetarianSelected,
              //       isVeganSelected);
              // });
            },
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 20),
          ),
        ],
      ),
    );
  }

  void _setScreen(String identifier) {
    // Navigator.of(context).pop();
    // if (identifier == "meals") {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (ctx) => const MealsHomePage(),
    //     ),
    //   );
    // }
  }

  // void updateFilters(isGlutenFreeSelected, isLactoseFreeSelected,
  //     isVegetarianSelected, isVeganSelected) {

  //     }
}
