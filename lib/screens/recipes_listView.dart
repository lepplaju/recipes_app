import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({super.key});

  @override
  RecipeListState createState() => RecipeListState();
}

class RecipeListState extends ConsumerState<RecipeList> {
  createColumnItems() {
    var screenWidth = MediaQuery.of(context).size.width;

    var containers = ref.watch(recipeProvider).map((recipe) => Container(
        padding: EdgeInsets.only(
            left: screenWidth / 15,
            right: screenWidth / 15,
            top: 20,
            bottom: 5),
        child: InkWell(
            onTap: () {
              context.go('/recipe/${recipe.id}');
            },
            child: Container(
                child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                  Expanded(
                    child: Center(
                        child: Text(
                      recipe.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 30),
                    )),
                  ),
                  Expanded(
                      //height: MediaQuery.of(context).size.width / 3,
                      child: Image(
                          height: MediaQuery.of(context).size.width / 3,
                          image: AssetImage("assets/hamburger1.jpg")))
                ]))))));
    return containers;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              children: [Text("List of recipes:"), ...createColumnItems()])),
    );
  }
}
