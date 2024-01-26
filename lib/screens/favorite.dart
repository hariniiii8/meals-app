import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';
class CalorieProgressTracker extends StatelessWidget {
  final double caloriesConsumed;
  final double goalCalories;

  CalorieProgressTracker({
    required this.caloriesConsumed,
    required this.goalCalories,
  });

  @override
  Widget build(BuildContext context) {
    double progress = caloriesConsumed / goalCalories;

    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 20,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Calories Consumed: ${caloriesConsumed.toStringAsFixed(2)} kcal',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          'Goal: ${goalCalories.toStringAsFixed(2)} kcal',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class FavScreen extends StatelessWidget {
  const FavScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
       CalorieProgressTracker(
          caloriesConsumed: 1500,  // Replace with actual consumed calories
          goalCalories: 3000,  // Replace with your goal calories
        ),
        SizedBox(height: 10),
     const SizedBox(height: 10),  // Add some space between text and listview
      Expanded(
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            },
          ),
        ),
      ),
    ],
    );
    
    ;
   
    if(meals.isEmpty)
    {
      Widget content=Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}