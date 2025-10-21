import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:Meal_App_Upgrades/providers/planner_meal_provider.dart';
import 'package:Meal_App_Upgrades/screens/meal_details.dart';
import 'package:Meal_App_Upgrades/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class BuildMealPlanTime extends ConsumerWidget {
  const BuildMealPlanTime({super.key, required this.day, required this.type});
  
  final WeekDay day;
  final MealType type;

  void selectMeal(BuildContext context, Meal meal) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(
            meal: meal,
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final String title = mealTypeString(type);
  final allMeals = ref.watch(plannerMealsProvider);
  final meals = allMeals
      .where((meal) => meal.weekDay == day && meal.mealType == type)
      .toList();

  if (meals.isEmpty){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            'No meals have been added here',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        textAlign: TextAlign.center,
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
            ),
          ),
          key: ValueKey(meals[index].id),
          onDismissed: (direction) {
            ref.read(plannerMealsProvider.notifier).removeFromPlanner(meals[index]);
          },
          child: MealItem(
            meal: meals[index],
            onSelectMeal: (BuildContext ctx, Meal meal) {
              selectMeal(ctx, meal);
            },
          ),
        ),
      ),
      const SizedBox(height: 12),
    ],
  );
  }
}
