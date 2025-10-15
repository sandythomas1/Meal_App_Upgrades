import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Meal_App_Upgrades/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
