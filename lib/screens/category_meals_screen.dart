import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../utils/dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String id;
  // final String title;
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String title = routeArgs['title']!;
    final String id = routeArgs['id']!;
    final categoryMeals = DUMMY_MEALS.where((meal) => meal.categories.contains(id)).toList();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(itemBuilder: (context, index) {
        return MealItem(
          id: categoryMeals[index].id,
          title: categoryMeals[index].title,
          imageUrl: categoryMeals[index].imageUrl,
          duration: categoryMeals[index].duration,
          complexity: categoryMeals[index].complexity,
          affordability: categoryMeals[index].affordability
        );
      }, itemCount: categoryMeals.length,)
    );
  }
}
