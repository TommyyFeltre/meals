import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = 'category-meals';
  // final String id;
  // final String title;
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String title = routeArgs['title']!;
    final String id = routeArgs['id']!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('The Recipes For The Category!'),
      ),
    );
  }
}
