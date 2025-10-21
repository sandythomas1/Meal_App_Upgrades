import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:Meal_App_Upgrades/providers/planner_meal_provider.dart';

class NewPlannerMeal extends ConsumerStatefulWidget {
  const NewPlannerMeal({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<NewPlannerMeal> createState() => _NewPlannerMealState();
}



class _NewPlannerMealState extends ConsumerState<NewPlannerMeal> {
  final _typeController = TextEditingController();
  final _dayController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  void _submitPlannerData () {
    // PlannerMeal pmeal = PlannerMeal.mealConvert(widget.meal, GetWeekDayFromString(_selectedDay.name), GetMealTypeFromString(_selectedMealType));
    PlannerMeal pmeal = PlannerMeal.mealConvert(widget.meal, _selectedDay, _selectedMealType);
    ref.read(plannerMealsProvider.notifier).addToPlanner(pmeal);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal added to planner!'),
        ),
    );
    Navigator.pop(context);
  }

  WeekDay _selectedDay = WeekDay.Monday;
  MealType _selectedMealType = MealType.Breakfast;

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom; 
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    dropdownColor: Colors.brown,
                    value: _selectedDay,
                    style: const TextStyle(
                      color: Colors.white, // ✅ selected item text color (unexpanded box)
                    ),
                    items: WeekDay.values.map(
                      (day) => DropdownMenuItem(
                          value: day,
                          child: Text(
                            day.name.toUpperCase(),
                            selectionColor: Colors.white,
                            ),
                        )
                      ).toList(), 
                    onChanged: (value) {
                      if (value == null){
                        return;
                      }
                      setState((){
                        _selectedDay = value;
                      });
                    }),
                    DropdownButton(
                    dropdownColor: Colors.brown,
                    value: _selectedMealType,
                    style: const TextStyle(
                      color: Colors.white, // ✅ selected item text color (unexpanded box)
                    ),
                    items: MealType.values.map(
                        (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              mealTypeString(type).toUpperCase(),
                              selectionColor: Colors.white,
                              ),
                          )
                        ).toList(), 
                    onChanged: (value) {
                      if (value == null){
                        return;
                      }
                      setState((){
                        _selectedMealType = value;
                      });
                  }),
                  ElevatedButton(onPressed: _submitPlannerData,
                  child: const Text('Save Meal To Planner',
                   selectionColor: Colors.white,
                   ))
              ],
            ),
          )
        ),
      );
    },
    );
  }
}