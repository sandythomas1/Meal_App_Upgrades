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
  PlannerMeal({required super.id, required super.categories, required super.title, required super.imageUrl, required super.ingredients, required super.steps, required super.duration, required super.complexity, required super.affordability, required super.isGlutenFree, required super.isLactoseFree, required super.isVegan, required super.isVegetarian, required this.weekDay, required this.mealType, this.firebaseId});
  
  PlannerMeal.mealConvert(Meal meal, WeekDay day, MealType type)
        : weekDay = day,
          mealType = type,
          firebaseId = null,
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
          
    final WeekDay weekDay;
    final MealType mealType;
    final String? firebaseId;

    Meal get meal {
    return Meal(            
      id: id,
      categories: categories,
      title: title,      
      imageUrl: imageUrl,
      ingredients: ingredients,
      steps: steps,
      duration: duration,
      complexity: complexity,
      affordability: affordability,
      isGlutenFree: isGlutenFree,
      isLactoseFree: isLactoseFree,
      isVegan: isVegan,
      isVegetarian: isVegetarian,);
    }

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'categories': categories,
        'title': title,
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'steps': steps,
        'duration': duration,
        'complexity': complexity.index,
        'affordability': affordability.index,
        'isGlutenFree': isGlutenFree,
        'isLactoseFree': isLactoseFree,
        'isVegan': isVegan,
        'isVegetarian': isVegetarian,
        'weekDay': weekDay.index,
        'mealType': mealType.index,
      };
    }

    factory PlannerMeal.fromJson(Map<String, dynamic> json, String firebaseId) {
      return PlannerMeal(
        id: json['id'],
        categories: List<String>.from(json['categories']),
        title: json['title'],
        imageUrl: json['imageUrl'],
        ingredients: List<String>.from(json['ingredients']),
        steps: List<String>.from(json['steps']),
        duration: json['duration'],
        complexity: Complexity.values[json['complexity']],
        affordability: Affordability.values[json['affordability']],
        isGlutenFree: json['isGlutenFree'],
        isLactoseFree: json['isLactoseFree'],
        isVegan: json['isVegan'],
        isVegetarian: json['isVegetarian'],
        weekDay: WeekDay.values[json['weekDay']],
        mealType: MealType.values[json['mealType']],
        firebaseId: firebaseId,
      );
    }

    PlannerMeal copyWith({String? firebaseId}) {
      return PlannerMeal(
        id: id,
        categories: categories,
        title: title,
        imageUrl: imageUrl,
        ingredients: ingredients,
        steps: steps,
        duration: duration,
        complexity: complexity,
        affordability: affordability,
        isGlutenFree: isGlutenFree,
        isLactoseFree: isLactoseFree,
        isVegan: isVegan,
        isVegetarian: isVegetarian,
        weekDay: weekDay,
        mealType: mealType,
        firebaseId: firebaseId ?? this.firebaseId,
      );
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
