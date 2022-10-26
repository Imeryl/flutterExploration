import 'package:flutter/material.dart';

import 'category_item.dart';
import 'dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DeliMeal',
        ),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map(
              (categoryData) => CategoryItem(
                color: categoryData.color,
                title: categoryData.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
