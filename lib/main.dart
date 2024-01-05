import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan' : false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _setFilters (Map<String, bool> filterData) {
    _filters = filterData;
    _availableMeals = DUMMY_MEALS.where((meal) {
      if(_filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if(_filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if(_filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if(_filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  void _toggleFavorites(String mealId) {
    final existingIndex = _favorites.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        _favorites.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favorites.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primaryColor: Colors.pink,
        colorScheme: const ColorScheme.light(
          onPrimaryContainer: Colors.amber,
          background:Color.fromRGBO(255, 254, 229, 1)
        ),
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.amber,
          backgroundColor: Colors.pink,
          unselectedItemColor: Colors.white
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromRGBO(255, 254, 229, 1)
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        '/': (context) => TabsScreen(_favorites),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorites, _isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(_filters, _setFilters) 
      },
      //onGenerateRoute: , used to prevent user to go in a not defined route and routes him in a choosen route
      //used when the app failed to load a page and when no routes and onGenerateRoute are not defined
      onUnknownRoute: ((settings) => MaterialPageRoute(builder: (context) => const CategoriesScreen())),

    );
  }
}
