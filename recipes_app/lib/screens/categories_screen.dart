import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
      ),
      padding: const EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
          .map(
            (categoryData) => CategoryItem(
              color: categoryData.color,
              id: categoryData.id,
              title: categoryData.title,
            ),
          )
          .toList(),
    );
  }
}
