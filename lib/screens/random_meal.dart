import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Meal_App_Upgrades/models/meal.dart';
import 'package:Meal_App_Upgrades/providers/filters_provider.dart';
import 'package:Meal_App_Upgrades/screens/meal_details.dart';
import 'package:Meal_App_Upgrades/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class RandomMealScreen extends ConsumerStatefulWidget {
  const RandomMealScreen({super.key});

  @override
  ConsumerState<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends ConsumerState<RandomMealScreen> {
  Meal? _randomMeal;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    // We'll select the random meal in didChangeDependencies since we need the provider
  }

  void _selectRandomMeal(List<Meal> availableMeals) {
    if (availableMeals.isEmpty) {
      setState(() {
        _randomMeal = null;
      });
      return;
    }

    setState(() {
      _randomMeal = availableMeals[_random.nextInt(availableMeals.length)];
    });
  }

  void _onMealTap() {
    if (_randomMeal != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(meal: _randomMeal!),
        ),
      );
    }
  }

  String get complexityText {
    if (_randomMeal == null) return '';
    return _randomMeal!.complexity.name[0].toUpperCase() + 
           _randomMeal!.complexity.name.substring(1);
  }

  String get affordabilityText {
    if (_randomMeal == null) return '';
    return _randomMeal!.affordability.name[0].toUpperCase() + 
           _randomMeal!.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    // Select initial random meal if not already selected
    if (_randomMeal == null && availableMeals.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _selectRandomMeal(availableMeals);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Meal'),
      ),
      body: availableMeals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No meals available!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Try adjusting your filters.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            )
          : _randomMeal == null
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 2,
                      child: InkWell(
                        onTap: _onMealTap,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(_randomMeal!.imageUrl),
                              fit: BoxFit.cover,
                              height: 300,
                              width: double.infinity,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _randomMeal!.title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MealItemTrait(
                                        icon: Icons.schedule,
                                        label: '${_randomMeal!.duration} min',
                                      ),
                                      const SizedBox(width: 12),
                                      MealItemTrait(
                                        icon: Icons.work,
                                        label: complexityText,
                                      ),
                                      const SizedBox(width: 12),
                                      MealItemTrait(
                                        icon: Icons.attach_money,
                                        label: affordabilityText,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      floatingActionButton: availableMeals.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _selectRandomMeal(availableMeals),
              child: const Icon(Icons.shuffle),
            )
          : null,
    );
  }
}