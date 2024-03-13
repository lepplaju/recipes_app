import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class CustomTopBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomTopBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  ConsumerState<CustomTopBar> createState() => _CustomTopBarState();
}

class _CustomTopBarState extends ConsumerState<CustomTopBar> {
  final SearchController controller = SearchController();

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    List<NewRecipe> tempRecipes = ref.watch(recipeProvider);
    return AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: Image.asset("assets/recepties_logo_transp.png"),
        title: Center(
          child: user.value != null
              ? Text('You are logged in!')
              //ElevatedButton(onPressed: logout, child: const Text('logout'))

              : const Text("not logged in"),
        ),
        // : ElevatedButton.icon(
        //     icon: const Icon(Icons.login),
        //     label: const Text('Login anonymously'),
        //     onPressed: () async {
        //       await FirebaseAuth.instance.signInAnonymously();
        //     },
        //   ),
        actions: [
          Column(
            children: <Widget>[
              SearchAnchor(
                  searchController: controller,
                  builder: (BuildContext context, SearchController controller) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                controller.openView();
                              },
                            )));
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    final String filterText =
                        controller.value.text.toLowerCase();
                    final List<NewRecipe> filteredRecipes =
                        tempRecipes.where((recipe) {
                      final String recipeName = recipe.name.toLowerCase();

                      return recipeName.contains(filterText);
                    }).toList();

                    return filteredRecipes.map((recipe) {
                      final String recipeName = recipe.name;
                      return ListTile(
                        title: Text(recipeName),
                        onTap: () {
                          setState(() {
                            controller.closeView(recipeName);
                            context.go('/recipe/${recipe.id}');
                          });
                        },
                      );
                    });
                  }),
            ],
          )
        ]);
  }
}
