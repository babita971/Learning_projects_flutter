import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/model/meal_data_model.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:transparent_image/transparent_image.dart';

class BasicMealWidget extends StatelessWidget {
  const BasicMealWidget(
      {super.key, required this.meal});
 
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetails(
                meal: meal,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Image.network(
              //   meal.imageUrl,
              //   fit: BoxFit.cover,
              //   height: 200,
              //   width: double.infinity,
              // ),
              // OR with animations using 3rd party package
              Hero(
                tag: meal.id, //Unique per widget
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.black54,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        meal.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis, // Etc...
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MealsMetaWidget(
                            icon: Icons.schedule,
                            label: "${meal.duration} min",
                          ),
                          MealsMetaWidget(
                            icon: Icons.bakery_dining,
                            label: meal.complexity.name,
                          ),
                          MealsMetaWidget(
                            icon: Icons.attach_money,
                            label: meal.affordability.name,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Container(
              //   alignment: Alignment.center,
              //   height: 100,
              //   width: double.infinity,
              //   color: Colors.black54,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         meal.title,
              //         style: Theme.of(context).textTheme.bodyLarge!,
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Row(
              //             children: [
              //               const Icon(
              //                 Icons.access_time_rounded,
              //                 color: Colors.white,
              //               ),
              //               Text(
              //                 "${meal.duration} min",
              //                 style: Theme.of(context).textTheme.bodySmall!,
              //               ),
              //             ],
              //           ),
              //           Row(
              //             children: [
              //               const Icon(
              //                 Icons.bakery_dining_rounded,
              //                 color: Colors.white,
              //               ),
              //               Text(
              //                 (meal.complexity.name).capitalize(),
              //                 style: Theme.of(context).textTheme.bodySmall!,
              //               ),
              //             ],
              //           ),
              //           Row(
              //             children: [
              //               const Icon(
              //                 Icons.currency_rupee,
              //                 color: Colors.white,
              //               ),
              //               Text(
              //                 (meal.affordability.name).capitalize(),
              //                 style: Theme.of(context).textTheme.bodySmall!,
              //               ),
              //             ],
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealsMetaWidget extends StatelessWidget {
  const MealsMetaWidget({super.key, required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(width: 4),
        Text(
          (label).capitalize(),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ],
    );
  }
}
