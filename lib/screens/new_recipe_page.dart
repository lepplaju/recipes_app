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
  const RecipePageConsumer({super.key});

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

    addRecipe(String name, String category, String ingredients, String steps) {
      var mockId = idGenerator();
      var newRecipe = Recipe(
          id: mockId,
          name: name,
          category: category,
          ingredients: [ingredients],
          steps: [steps]);
      ref.watch(recipeProvider.notifier).addRecipe(newRecipe);
    }

    return Scaffold(
        body: Expanded(
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(children: [
                  const Text('hello world'),
                  Row(children: [
                    const Text("Name:"),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    const Text("Category:"),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: categoryController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Category',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    const Text("Ingredients:"),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: ingredientsController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ingredients',
                              ),
                            ))),
                  ]),
                  Row(children: [
                    const Text("Steps:"),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            child: TextField(
                              controller: stepsController,
                              decoration: const InputDecoration(
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
                          addRecipe(
                              nameController.text.toString(),
                              categoryController.text.toString(),
                              ingredientsController.text.toString(),
                              stepsController.text.toString());
                          nameController.clear();
                          categoryController.clear();
                          ingredientsController.clear();
                          stepsController.clear();
                        } else {
                          // TODO: POPUP
                        }
                      },
                      child: const Text("Add recipe")),
                ]))));
  }
}
