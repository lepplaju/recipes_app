import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class ModifyingRecipe extends ConsumerStatefulWidget {
  final String recipeId;
  const ModifyingRecipe({super.key, required this.recipeId});
  @override
  ModifyingRecipeState createState() => ModifyingRecipeState();
}

class ModifyingRecipeState extends ConsumerState<ModifyingRecipe> {
  @override
  Widget build(BuildContext context) {
    var recipeId = widget.recipeId;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("hello there"),
      Text("recipeID: $recipeId"),
      FutureBuilder(
          future: ref.watch(recipeProvider.notifier).getRecipeById(recipeId),
          builder: (BuildContext context, AsyncSnapshot<NewRecipe?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                  child: Container(
                      width: screenWidth / 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Recipe name:"),
                                  Text("${snapshot.data!.name}")
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Categories:"),
                                  Text("${snapshot.data!.categories}"),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Ingredients:"),
                                  Text("${snapshot.data!.ingredients}"),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Steps:"),
                                  Text("${snapshot.data!.steps}"),
                                ]),
                            ElevatedButton(
                                onPressed: () {
                                  print("todo saving");
                                },
                                child: Text("Save & Exit"))
                          ])));
            }
          }),
    ])));
  }
}
