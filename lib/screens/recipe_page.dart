import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeScreen extends ConsumerStatefulWidget {
  final String recipeId;
  const RecipeScreen({super.key, required this.recipeId});

  @override
  RecipeScreenState createState() => RecipeScreenState();
}

class RecipeScreenState extends ConsumerState<RecipeScreen> {
  NewRecipe? recipeToDisplay;

  @override
  Widget build(BuildContext context) {
    var recipeId = widget.recipeId;
    var oneRecipe = ref.watch(recipeProvider.notifier).getRecipeById(recipeId);

    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
      Container(
          margin: EdgeInsets.all(30),
          child: ElevatedButton(
            onPressed: () {
              context.go("/");
            },
            child: Text("Go home"),
          )),
      FutureBuilder(
          future: oneRecipe,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: RecipeWidget(recipeToDisplay: snapshot.data!));
            } else if (snapshot.hasError) {
              return Text("error");
            } else {
              return CircularProgressIndicator();
            }
          })
    ]))));
  }
}

class RecipeWidget extends StatelessWidget {
  final NewRecipe recipeToDisplay;
  const RecipeWidget({Key? key, required this.recipeToDisplay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Recipe name: ${recipeToDisplay.name}"),
        Text("Recipe categories: ${recipeToDisplay.categories}"),
        const SizedBox(
            width: 300,
            child: Placeholder(
              fallbackHeight: 300,
            )),
        const Text(
          "Ingredients:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(recipeToDisplay.ingredients.toString()),
        const Text(
          "Steps:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(recipeToDisplay.steps.toString()),
      ],
    );
  }
}
