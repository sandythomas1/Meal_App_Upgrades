enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}

enum WeekDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

enum MealType {
  Breakfast,
  Lunch,
  Dinner,
}

class PlannerMeal extends Meal {
  PlannerMeal({required super.id, required super.categories, required super.title, required super.imageUrl, required super.ingredients, required super.steps, required super.duration, required super.complexity, required super.affordability, required super.isGlutenFree, required super.isLactoseFree, required super.isVegan, required super.isVegetarian, required this.weekDay, required this.mealType});
  PlannerMeal.mealConvert(Meal meal, WeekDay day, MealType type)
        : weekDay = day,
          mealType = type,
          super(
            id: meal.id,
            categories: meal.categories,
            title: meal.title,
            imageUrl: meal.imageUrl,
            ingredients: meal.ingredients,
            steps: meal.steps,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
            isGlutenFree: meal.isGlutenFree,
            isLactoseFree: meal.isLactoseFree,
            isVegan: meal.isVegan,
            isVegetarian: meal.isVegetarian,
          );
          
    final weekDay;
    final mealType;

    Meal get meal {
    return Meal(            
      id: meal.id,
      categories: meal.categories,
      title: meal.title,      
      imageUrl: meal.imageUrl,
      ingredients: meal.ingredients,
      steps: meal.steps,
      duration: meal.duration,
      complexity: meal.complexity,
      affordability: meal.affordability,
      isGlutenFree: meal.isGlutenFree,
      isLactoseFree: meal.isLactoseFree,
      isVegan: meal.isVegan,
      isVegetarian: meal.isVegetarian,);
    }
  }

  String mealTypeString(MealType type){
    if (type == MealType.Breakfast){
      return 'Breakfast';
    }
    else if (type == MealType.Lunch){
      return 'Lunch';
    }
    else{
      return 'Dinner';
    }
  }

  MealType GetMealTypeFromString(String input){
    input = input.toUpperCase();
    if (input == mealTypeString(MealType.Breakfast).toUpperCase()){
      return MealType.Breakfast;
    }
    else if (input == mealTypeString(MealType.Lunch).toUpperCase()){
      return MealType.Lunch;
    }
    else{
     return MealType.Dinner;
    }
  }

  WeekDay GetWeekDayFromString(input){
    if (input == 'MONDAY'){
      return WeekDay.Monday;
    }
    else if (input == 'TUESDAY'){
      return WeekDay.Tuesday;
    }
    else if (input == 'WEDNESDAY'){
      return WeekDay.Wednesday;
    }
    else if (input == 'THURSDAY'){
      return WeekDay.Thursday;
    }
    else if (input == 'FRIDAY'){
      return WeekDay.Friday;
    }
    else if (input == 'SATURDAY'){
      return WeekDay.Saturday;
    }
    else {
      return WeekDay.Sunday;
    }
  }
