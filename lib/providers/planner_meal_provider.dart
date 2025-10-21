import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


class PlannerMealsNotifier extends StateNotifier<List<PlannerMeal>>{
  PlannerMealsNotifier() : super([]);


  void addToPlanner(PlannerMeal meal){
    state = [...state, meal];
  }

  void removeFromPlanner(PlannerMeal meal){
    state = state.where((m) => m.id != meal.id).toList();
  }

  List<PlannerMeal> getDayTypeMeals(WeekDay day, MealType type){
    return state.where((meal) => (meal.weekDay == day)&&(meal.mealType == type))
      .toList();
  }
}

final plannerMealsProvider = 
  StateNotifierProvider<PlannerMealsNotifier, List<PlannerMeal>>((ref) {
    return PlannerMealsNotifier();
  });

