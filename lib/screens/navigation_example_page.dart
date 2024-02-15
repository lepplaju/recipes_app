import 'package:flutter/material.dart';
import 'package:recipe_app/screens/category_page.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:recipe_app/screens/recipes_listView.dart';
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
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomTopBar(),
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
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),

        /// Categories page
        CategoriesPage(),

        /// Recipes page
        RecipeList(),

        // Trending page
        Padding(padding: EdgeInsets.all(10), child: RecipePage())
      ][currentPageIndex],
    );
  }
}
