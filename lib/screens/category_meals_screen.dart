import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  // final String id;
  // final String title;
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title = '';
  List<Meal> categoryMeals = [];
  var _loadedInitData = false;

  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      title = routeArgs['title']!;
      final String id = routeArgs['id']!;
      categoryMeals = widget.availableMeals.where((meal) => meal.categories.contains(id)).toList();
      _loadedInitData = true;
    }
    
    super.didChangeDependencies();
  }

  void _removeMeal(String id) {
    setState(() {
      categoryMeals.removeWhere((categotyMeal) => categotyMeal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(itemBuilder: (context, index) {
        return MealItem(
          id: categoryMeals[index].id,
          title: categoryMeals[index].title,
          imageUrl: categoryMeals[index].imageUrl,
          duration: categoryMeals[index].duration,
          complexity: categoryMeals[index].complexity,
          affordability: categoryMeals[index].affordability,
        );
      }, itemCount: categoryMeals.length,)
    );
  }
}
