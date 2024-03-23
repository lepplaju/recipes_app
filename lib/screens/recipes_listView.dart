import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/favorites_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({super.key});

  @override
  RecipeListState createState() => RecipeListState();
}

class RecipeListState extends ConsumerState<RecipeList> {
  bool? showRecipe;
  NewRecipe? chosenRecipe;
  double containerWidth = 0;
  var user;

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
              setState(() {
                chosenRecipe = recipe;
                showRecipe = true;
                containerWidth = 400;
              });
              print("setting the showRecipeValue...");
              //context.go('/recipe/${recipe.id}');
            },
            child: Container(
                constraints: BoxConstraints(maxHeight: 200),
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

                          child: Container(
                              margin: EdgeInsets.all(20),
                              child: Image(
                                  image: AssetImage("assets/hamburger1.jpg"))))
                    ]))))));
    return containers;
  }

  showChosenRecipe() {
    return Center(
        child: (Column(children: [
      Text("Chosen recipe name: ${chosenRecipe!.name}"),
      Text("Ingredients: ${chosenRecipe!.ingredients}"),
      ElevatedButton(
          onPressed: () {
            setState(() {
              showRecipe = false;
              containerWidth = 0;
            });
          },
          child: Text("close recipe")),
      SizedBox(
        height: 25,
      ),
      user != null && user!.value != null
          ? Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {
                    print("user: ${user!.value!.uid}");
                    print('reicpe ${chosenRecipe!.id}');
                    ref
                        .watch(favoritesProvider.notifier)
                        .addFavoriteToUser(user!.value!.uid, chosenRecipe!.id);
                  },
                  icon: Icon(Icons.star_border)),
            )
          : SizedBox(),
    ])));
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
    //print(user);
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20),
      child: showRecipe != null &&
              showRecipe! &&
              chosenRecipe != null &&
              screenWidth < 800
          ? showChosenRecipe()
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                Text("List of recipes:"),
                ...createColumnItems()
              ]))),
              showRecipe != null &&
                      showRecipe! &&
                      chosenRecipe != null &&
                      screenWidth >= 800
                  ? Container(width: containerWidth, child: showChosenRecipe())
                  : SizedBox(),
            ]),
    );
  }
}
