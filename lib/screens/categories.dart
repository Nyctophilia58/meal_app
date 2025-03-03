import 'package:flutter/material.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import 'package:meal_app/screens/meals.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: "some title",
          meals: [],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
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
              _selectCategory(context);
            },),
        ],
      )
    );
  }
}