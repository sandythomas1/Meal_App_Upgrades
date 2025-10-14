import 'package:flutter/material.dart'; 
import '../data/dummy_data.dart';
import '../widgets/category_grid_item.dart';
import 'meals.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

// have never added method to a stateless widget before
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
    .where((meal) => meal.categories.contains(category.id))
    .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 3 / 2, 
          crossAxisSpacing: 20, 
          mainAxisSpacing: 20,
          ),
          children: [
            // availableCategories.map((category) => Text(category.title)).toList(),
           for (final category in availableCategories)
            CategoryGridItem(category: category, onSelectCategory: () {
              _selectCategory(context, category);
          },
        ),
      ],
    );
  }
}