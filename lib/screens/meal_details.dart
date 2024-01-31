import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    Key? key,
    required this.meal,
    required this.onToggleFavorite,
  }) : super(key: key);

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int selectedQuantity = 1; // Default selected quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              widget.onToggleFavorite(widget.meal);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        color: Color.fromRGBO(138, 71, 235, 1), // Set your desired background color here
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 14),
              // Dropdown for quantity selection
              DropdownButton<int>(
                value: selectedQuantity,
                onChanged: (value) {
                  setState(() {
                    // Update the selected quantity
                    selectedQuantity = value!;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, // Change text color to white
                    ),
                dropdownColor: Color.fromRGBO(138, 71, 235, 1), // Set dropdown background color
                items: List.generate(10, (index) => index + 1)
                    .map((quantity) => DropdownMenuItem<int>(
                          value: quantity,
                          child: Text(
                            '$quantity',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white, // Change text color to white
                                ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 14),
              // Display calories information
              Text(
                'Calories: ${widget.meal.calories * selectedQuantity} kcal',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, // Change text color to white
                    ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in widget.meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in widget.meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
