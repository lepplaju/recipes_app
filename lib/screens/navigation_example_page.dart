import 'package:flutter/material.dart';
import 'package:recipe_app/screens/categories_page.dart';
import 'package:recipe_app/screens/main_page.dart';
import 'package:recipe_app/screens/new_recipe_page.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:recipe_app/screens/recipes_listview.dart';
import 'package:recipe_app/widgets/custom_top_bar.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopBar(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.topic_outlined),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.trending_up_sharp,
            ),
            label: 'Trending',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_box_rounded,
            ),
            label: 'Add new recipe ',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const MainPage(),

        /// Categories page
        const CategoriesPage(),

        /// Recipes page
        const RecipeList(),

        // Trending page
        const Padding(
            padding: EdgeInsets.all(10),
            child: Text("todo treding page")), // RecipeWidget()),

        // Add new recipe page
        const RecipePageConsumer(),
      ][currentPageIndex],
    );
  }
}
