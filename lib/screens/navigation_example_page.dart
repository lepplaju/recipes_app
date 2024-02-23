import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/screens/categories_page.dart';
import 'package:recipe_app/screens/login_or_create.dart';
import 'package:recipe_app/screens/main_page.dart';
import 'package:recipe_app/screens/new_recipe_page.dart';
import 'package:recipe_app/screens/recipes_listview.dart';
import 'package:recipe_app/widgets/custom_top_bar.dart';

class NavigationExample extends ConsumerStatefulWidget {
  const NavigationExample({super.key});

  @override
  ConsumerState<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends ConsumerState<NavigationExample> {
  int currentPageIndex = 0;
  String accountText = 'Account';

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    // if (currentPageIndex == 4 && user.value == null) {
    //   currentPageIndex = 0;
    // }
    List<NavigationDestination> navigationDestinations = [
      const NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.topic_outlined),
        label: 'Categories',
      ),
      const NavigationDestination(
        icon: Icon(Icons.list_alt_outlined),
        label: 'Recipes',
      ),
      const NavigationDestination(
        icon: Icon(
          Icons.trending_up_sharp,
        ),
        label: 'Trending',
      ),
      NavigationDestination(
          icon: Icon(Icons.manage_accounts_outlined), label: accountText)
      // const NavigationDestination(
      //   icon: Icon(
      //     Icons.add_box_rounded,
      //   ),
      //   label: 'Add new recipe',
      // ),
    ];
    if (user.value == null) {
      accountText = 'Sign in';
      // navigationDestinations.removeWhere((destination) =>
      //     destination.label ==
      //     'Add new recipe'); // Remove the destination if user value is null
    }
    return Scaffold(
      appBar: //AppBar(title: Text('sup')
          const CustomTopBar(),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: navigationDestinations //<Widget>[
          //   NavigationDestination(
          //     selectedIcon: Icon(Icons.home),
          //     icon: Icon(Icons.home_outlined),
          //     label: 'Home',
          //   ),
          //   NavigationDestination(
          //     icon: Icon(Icons.topic_outlined),
          //     label: 'Categories',
          //   ),
          //   NavigationDestination(
          //     icon: Icon(Icons.list_alt_outlined),
          //     label: 'Recipes',
          //   ),
          //   NavigationDestination(
          //     icon: Icon(
          //       Icons.trending_up_sharp,
          //     ),
          //     label: 'Trending',
          //   ),
          //   user.value != null
          //       ? NavigationDestination(
          //           icon: Icon(
          //             Icons.add_box_rounded,
          //           ),
          //           label: 'Add new recipe ',
          //         )
          //       : SizedBox(),
          // ],
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
        user.value == null ? const LoginScreen() : const SizedBox(),
      ][currentPageIndex],
    );
  }
}
