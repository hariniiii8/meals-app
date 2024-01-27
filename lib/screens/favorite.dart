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
        const SizedBox(height: 30),
        Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
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

class FavScreen extends StatefulWidget {
  const FavScreen({
    Key? key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  }) : super(key: key);

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  double totalConsumedCalories = 0.0; // State variable to track consumed calories

  @override
  void initState() {
    super.initState();
    updateTotalConsumedCalories();
  }

  void updateTotalConsumedCalories() {
    double totalCalories = 0.0;
    for (var meal in widget.meals) {
      totalCalories += meal.calories;
    }
    setState(() {
      totalConsumedCalories = totalCalories;
    });
  }

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: widget.onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        CalorieProgressTracker(
          caloriesConsumed: totalConsumedCalories,
          goalCalories: 3000, // Replace with your goal calories
        ),
        SizedBox(height: 10),
        Text( 'Total Calories consumed: ${totalConsumedCalories.toString()} kcal'
          ,style: TextStyle(fontSize: 16, color: Colors.grey),),
        const SizedBox(height: 10), // Add some space between text and listview
        Expanded(
          child: ListView.builder(
            itemCount: widget.meals.length,
            itemBuilder: (ctx, index) => MealItem(
              meal: widget.meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ),
          ),
        ),
      ],
    );

    if (widget.meals.isEmpty) {
      Widget content = Center(
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
      return content;
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: content,
    );
  }
}
