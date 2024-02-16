import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

// class NewRecipePage extends ConsumerStatefulWidget {
//   ConsumerState<NewRecipePage> createState() => _NewRecipePageState();
// }

// class _NewRecipePageState extends ConsumerState<NewRecipePage> {
//   @override
//   build(BuildContext context) {
//     return Text('temp');
//   }
// }

class RecipePageConsumer extends ConsumerWidget {
  idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  @override
  build(BuildContext context, WidgetRef ref) {
    final categoryController = TextEditingController();
    final ingredientsController = TextEditingController();
    final stepsController = TextEditingController();
    final nameController = TextEditingController();

    _addRecipe(String name, String category, String ingredients, String steps) {
      var mock_id = idGenerator();
      var newRecipe = Recipe(
          id: mock_id,
          name: name,
          category: category,
          ingredients: [ingredients],
          steps: [steps]);
      print("new recipe: ${newRecipe.name}");
      ref.watch(recipeProvider.notifier).addRecipe(newRecipe);
    }

    return Scaffold(
        body: Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Text('hello world'),
                  Row(children: [
                    Text("Name:"),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    Text("Category:"),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: categoryController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Category',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    Text("Ingredients:"),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: ingredientsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ingredients',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    Text("Steps:"),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: stepsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Steps',
                              ),
                            ))),
                  ]),
                  ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &
                            categoryController.text.isNotEmpty &
                            ingredientsController.text.isNotEmpty &
                            stepsController.text.isNotEmpty) {
                          _addRecipe(
                              nameController.text.toString(),
                              categoryController.text.toString(),
                              ingredientsController.text.toString(),
                              stepsController.text.toString());
                          nameController.clear();
                          categoryController.clear();
                          ingredientsController.clear();
                          stepsController.clear();
                        } else {
                          print("invalid");
                        }
                      },
                      child: Text("Add recipe")),
                ]))));
  }
}
