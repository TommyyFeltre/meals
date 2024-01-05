import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favorites;
  const FavoritesScreen(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    if(favorites.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(itemBuilder: (context, index) {
        return MealItem(
          id: favorites[index].id,
          title: favorites[index].title,
          imageUrl: favorites[index].imageUrl,
          duration: favorites[index].duration,
          complexity: favorites[index].complexity,
          affordability: favorites[index].affordability,
        );
      }, itemCount: favorites.length,);
    }
  }
}
