import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/widgets/custom_alert.dart';

// class NewRecipePage extends ConsumerStatefulWidget {
//   ConsumerState<NewRecipePage> createState() => _NewRecipePageState();
// }

// class _NewRecipePageState extends ConsumerState<NewRecipePage> {
//   @override
//   build(BuildContext context) {
//     return Text('temp');
//   }
// }

class RecipePageSW extends ConsumerStatefulWidget {
  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends ConsumerState<RecipePageSW> {
  idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  var selectedCategory;
  static const Color hintTextColor = Color(0xFF717571);

  @override
  build(BuildContext context) {
    final categoryController = TextEditingController();
    final ingredientsController = TextEditingController();
    final stepsController = TextEditingController();
    final nameController = TextEditingController();
    final user = ref.watch(userProvider);
    final categories = ref.watch(categoryProvider);

    var dropownMenuItems = categories.map((value) => DropdownMenuEntry<String>(
          value: value,
          label: value,
        ));

    addRecipe(String name, String category, String ingredients, String steps) {
      var userId = ref.watch(userProvider).value!.uid;
      print(userId);
      var mockId = idGenerator();
      var newRecipe = Recipe(
          userId: userId,
          id: mockId,
          name: name,
          category: category,
          ingredients: [ingredients],
          steps: [steps]);
      ref.watch(recipeProvider.notifier).addRecipe(newRecipe);
    }

    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Add a new recipe'),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            labelStyle: TextStyle(color: hintTextColor))),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 20),
                      child: Column(children: [
                        DropdownMenu(
                          initialSelection: categories.first,
                          controller: categoryController,
                          label: Text("Category:"),
                          expandedInsets: EdgeInsets.zero,
                          dropdownMenuEntries: dropownMenuItems.toList(),
                          onSelected: (String? value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ])),
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        controller: ingredientsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ingredients',
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        controller: stepsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Steps',
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        print(selectedCategory);
                        if (nameController.text.isNotEmpty &
                            ingredientsController.text.isNotEmpty &
                            stepsController.text.isNotEmpty) {
                          addRecipe(
                              nameController.text.toString(),
                              selectedCategory.toString(),
                              ingredientsController.text.toString(),
                              stepsController.text.toString());
                          nameController.clear();
                          categoryController.clear();
                          ingredientsController.clear();
                          stepsController.clear();
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  CustomAlertDialog(pretext: "Adding failed"));
                        }
                      },
                      child: const Text("Add recipe")),
                  SizedBox(
                    height: 150,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.go("/");
                      },
                      child: Text("Go home")),
                ])));
  }
}
