import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters.dart';
import '../models/meal.dart';
import '../widgets/drawer.dart';
import 'categories.dart';
import 'meals.dart';


class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(BuildContext context, String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage(context, 'Meal is removed from favorites');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage(context, 'Meal is added to favorites');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(toggleFavorite: _toggleFavorite );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: _favoriteMeals, toggleFavorite: _toggleFavorite);
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: MyDrawer(onSelected: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}