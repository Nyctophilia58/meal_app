import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({Key? key}) : super(key: key);

  void _selectCategory(BuildContext context, String categoryId, String categoryTitle){
    Navigator.of(context).pushNamed(
      '/category-meals',
      arguments: {
        'id': categoryId,
        'title': categoryTitle,
      },
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
            CategoryGridItem(category: category),
        ],
      )
    );
  }
}