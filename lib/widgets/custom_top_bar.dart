import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class CustomTopBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTopBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<CustomTopBar> createState() => _CustomTopBarState();
}

class _CustomTopBarState extends State<CustomTopBar> {
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    List<Recipe> tempRecipes = MockRecipeData().getRecipes();
    return AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: const Center(child: Text('Recipe app!')),
        actions: [
          Column(
            children: <Widget>[
              SearchAnchor(
                  viewBackgroundColor: Colors.amber,
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
                    return tempRecipes.map((recipe) {
                      final String recipeName = recipe.name;
                      return ListTile(
                        title: Text(recipeName),
                        onTap: () {
                          setState(() {
                            controller.closeView(recipeName);
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
