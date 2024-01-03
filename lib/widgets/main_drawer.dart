import 'package:flutter/material.dart';
import 'package:meals/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      onTap: tapHandler,
      leading: Icon(icon, size: 26,),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            height: (mediaQuery.size.height * 0.12),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          SizedBox(height: (mediaQuery.size.height * 0.02)),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () => Navigator.of(context).pushNamed('/')
          ),
          buildListTile(
            'Filters',
            Icons.filter_alt_sharp,
            () => Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName)
          ),
        ]
      ),
    );
  }
}