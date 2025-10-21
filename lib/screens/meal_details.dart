import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:Meal_App_Upgrades/providers/favorites_provider.dart';
import 'package:Meal_App_Upgrades/screens/new_planner_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(title: Text(meal.title), actions: [
          
          IconButton(
            onPressed: () {
              final bool wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(wasAdded ? 'Meal added as a favorite': 'Meal removed.'),
                  ),
                );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(microseconds: 300),
              transitionBuilder: (child, animation){
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1,).animate(animation), 
                  child: child,
                  );
              },
            
              child: Icon(isFavorite ? Icons.star: Icons.star_border, key: ValueKey(isFavorite)),
            ),
          ),
        ]),
        body: 
        Scaffold(
          floatingActionButton: FloatingActionButton(
          shape: ShapeBorder.lerp(CircleBorder(), StadiumBorder(), 0.5),
          onPressed: () =>
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context, 
              builder: (ctx) => NewPlannerMeal(meal: meal),
            ),
          splashColor: Theme.of(context).primaryColor,
          child: Row(children: [Icon(Icons.add), Icon(Icons.calendar_month)]),
        ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: meal.id,
                  child: Image.network(
                    meal.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 14),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                const SizedBox(height: 24),
                Text(
                  'Steps',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 14),
                for (final step in meal.steps)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      step,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}