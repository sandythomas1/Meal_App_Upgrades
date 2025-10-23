import 'dart:convert';
import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;


class PlannerMealsNotifier extends StateNotifier<List<PlannerMeal>>{
  PlannerMealsNotifier() : super([]);

  static const String _firebaseUrl = 'https://meals-upgrade-ebdd2-default-rtdb.firebaseio.com/planner-meals.json';

  Future<void> loadPlannedMeals() async {
    try {
      final url = Uri.parse(_firebaseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        
        if (data == null) {
          state = [];
          return;
        }

        final List<PlannerMeal> loadedMeals = [];
        data.forEach((firebaseId, mealData) {
          loadedMeals.add(PlannerMeal.fromJson(mealData, firebaseId));
        });

        state = loadedMeals;
      }
    } catch (error) {
      print('Error loading meals: $error');
      // Keep current state if loading fails
    }
  }

  Future<void> addToPlanner(PlannerMeal meal) async {
    // Optimistically update UI
    state = [...state, meal];

    try {
      final url = Uri.parse(_firebaseUrl);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(meal.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final firebaseId = responseData['name'];
        
        // Update the meal with Firebase ID
        final updatedMeal = meal.copyWith(firebaseId: firebaseId);
        state = state.map((m) => m.id == meal.id && m.weekDay == meal.weekDay && m.mealType == meal.mealType ? updatedMeal : m).toList();
      } else {
        // Revert on failure
        state = state.where((m) => m != meal).toList();
      }
    } catch (error) {
      print('Error adding meal: $error');
      // Revert on failure
      state = state.where((m) => m != meal).toList();
    }
  }

  Future<void> removeFromPlanner(PlannerMeal meal) async {
    // Optimistically update UI
    final previousState = state;
    state = state.where((m) => m.firebaseId != meal.firebaseId).toList();

    try {
      if (meal.firebaseId != null) {
        final url = Uri.parse('https://meals-upgrade-ebdd2-default-rtdb.firebaseio.com/planner-meals/${meal.firebaseId}.json');
        final response = await http.delete(url);

        if (response.statusCode != 200) {
          // Revert on failure
          state = previousState;
        }
      }
    } catch (error) {
      print('Error removing meal: $error');
      // Revert on failure
      state = previousState;
    }
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

