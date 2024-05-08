import 'package:flutter/material.dart';

class BuildDrawerWidget extends StatelessWidget {
  const BuildDrawerWidget({
    super.key,
    required this.setScreen,
    // required this.callBack,
    // required this.isGlutenFreeSelected,
    // required this.isLactoseFreeSelected,
    // required this.isVeganSelected,
    // required this.isVegetarianSelected,
  });
  final void Function(String) setScreen;

  // final bool isVeganSelected;
  // final bool isLactoseFreeSelected;
  // final bool isGlutenFreeSelected;
  // final bool isVegetarianSelected;
  // final void Function(bool, bool) callBack;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onSecondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.fastfood,
                  size: 42,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Cooking Up!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.restaurant,
              size: 28,
            ),
            title: Text(
              "Meals",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setScreen('meals');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 28,
            ),
            title: Text(
              "Filters",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}


// if drawer is opened from home.
// if meals is pressed = close drawer.
// if filters is pressed = go to filters screen.
// if drawer is opened from filters screen.
// if pressed on meals then take to category home screen.
// if pressed on filters then do nothing.
// basically depending on the state of current screen and which option he has tapped.