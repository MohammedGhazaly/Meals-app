import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trait.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String getCapitlizedName(String trait) {
    return "${trait[0].toUpperCase()}${trait.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 42),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Wrap(
                        spacing: 10,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: "${meal.duration} min"),
                          MealItemTrait(
                              icon: Icons.work,
                              label: getCapitlizedName(meal.complexity.name)),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label:
                                  getCapitlizedName(meal.affordability.name)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
