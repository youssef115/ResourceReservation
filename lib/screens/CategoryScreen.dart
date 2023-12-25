import 'package:flutter/material.dart';
import 'package:flutter_spring/data/dummy_data.dart';
import 'package:flutter_spring/widgets/Category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3/2
            ),
          children: [
            for (final category in availableCategories)
            CategoryGridItem(category: category)
          ],
        ),
    )
    ;
  }
}