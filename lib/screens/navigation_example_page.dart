import 'package:flutter/material.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:recipe_app/screens/recipes_listView.dart';

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
      appBar: AppBar(
          leadingWidth: 100,
          centerTitle: true,
          leading: Center(child: const Text('Recipes App!')),
          title: TextField(
              decoration: InputDecoration(
            hintText: "Search Data...",
            hintStyle: TextStyle(color: Colors.blueGrey[200]),
          ))),
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
            icon: Icon(Icons.notifications_sharp),
            label: 'Notifications',
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

        /// Recipes page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        RecipeList(),

        // Trending page
        Padding(padding: EdgeInsets.all(10), child: RecipePage())
      ][currentPageIndex],
    );
  }
}
