


import 'package:flutter/material.dart';
import 'package:flutter_spring/data/dummy_data.dart';
import 'package:flutter_spring/models/Category_model.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/screens/tool_screen.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final List<Tool> filteredTool = dummyTools
            .where((element) => element.category.toString()==category.id)
            .toList();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ToolScreen(title: category.title, tools:filteredTool)));
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                category.color.withOpacity(0.54),
                category.color.withOpacity(0.9)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Text(category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ))),
    );
  }
}