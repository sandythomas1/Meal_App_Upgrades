import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:Meal_App_Upgrades/widgets/planner_meal_time.dart';




class PlannerScreen extends StatefulWidget {
  const PlannerScreen({
    super.key,
  });

  @override
  State<PlannerScreen> createState() {
    return _PlannerScreenState();
  }
}

class _PlannerScreenState extends State<PlannerScreen> {

    @override
    Widget build(BuildContext context) {      
      return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Monday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Monday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Monday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Monday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Tuesday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Tuesday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Tuesday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Tuesday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Wednesday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Wednesday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Wednesday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Wednesday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Thursday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Thursday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Thursday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Thursday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Friday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Friday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Friday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Friday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Saturday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Saturday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Saturday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Saturday, type: MealType.Dinner),
            const SizedBox(height: 24),

            Text('Sunday',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            BuildMealPlanTime(day: WeekDay.Sunday, type: MealType.Breakfast),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Sunday, type: MealType.Lunch),
            const SizedBox(height: 16),
            BuildMealPlanTime(day: WeekDay.Sunday, type: MealType.Dinner),
          ],
        );
    }
  }