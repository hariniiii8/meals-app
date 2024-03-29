import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/intro1.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/monthlypage.dart';
import 'package:meals/screens/favorite.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meals/screens/settings.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;
Map<String, int> _favoriteMealCounts = {};
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

   if (isExisting) {
      setState(() {
        // Meal is already in favorites, increment the count
        _favoriteMealCounts[meal.id] = (_favoriteMealCounts[meal.id] ?? 1) + 1;
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal tracked!');
       
    } else {
  final currentDate = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  final formattedDayOfWeek = DateFormat('EEEE').format(currentDate);
  final formattedTime = DateFormat('HH:mm:ss').format(currentDate);

  setState(() async {
    _favoriteMeals.add(meal);
    _favoriteMealCounts[meal.id] = 1;
    _showInfoMessage('Meal tracked');

    final url = Uri.https('newproject-cdc5a-default-rtdb.firebaseio.com', 'todays_meals.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'name': meal.title,
          'calories': meal.calories,
          'date': formattedDate,
          'dayOfWeek': formattedDayOfWeek,
          'time': formattedTime,
        },
      ),
    );
    print(response.body);
    print(response.statusCode);

  });
}

  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = FavScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Calories Today';
    }
     if (_selectedPageIndex == 2) {
      activePage = MonthlyPage();
      
    
  }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
         actions: [
          
          IconButton(
            icon: Icon(Icons.settings),
             onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingsScreen(userId: FirebaseAuth.instance.currentUser!.uid),
              ),
            );
          },
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Today',
          ),
           BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),  // Add an icon for MonthlyPage
      label: 'Monthly',
    ),
        ],
      ),
    );
  }
}