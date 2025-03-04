import 'package:flutter/material.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key, required this.toggleFavorite, required this.availableMeals});

  final void Function(Meal mean) toggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category){
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          toggleFavorite: toggleFavorite,
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
          for(final category in availableCategories)
            CategoryGridItem(category: category, onSelectCategory: (){
              _selectCategory(context, category);
            },),
        ],
      );
  }
}