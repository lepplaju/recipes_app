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
  const RecipePageSW({super.key});

  @override
  RecipePageState createState() => RecipePageState();
}

class RecipePageState extends ConsumerState<RecipePageSW> {
  idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  late String selectedCategory;
  static const Color hintTextColor = Color(0xFF717571);
  final categoryController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  final nameController = TextEditingController();
  final List<Widget> ingredientFieds = [
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: TextEditingController(),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Ingredient',
            labelStyle: TextStyle(color: hintTextColor)),
      ),
    ),
  ];
  var stepIndex = 1;
  final List<Widget> stepFieds = [
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: TextEditingController(),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '1. step',
            labelStyle: TextStyle(color: hintTextColor)),
      ),
    ),
  ];

  @override
  build(BuildContext context) {
    //final user = ref.watch(userProvider);
    final categories = ref.watch(categoryProvider);
    // var dropownMenuItems = [
    //   DropdownMenuEntry<String>(
    //     value: "value",
    //     label: "value",
    //   )
    // ];
    var dropownMenuItems =
        categories.map((category) => DropdownMenuEntry<String>(
              value: category.name,
              label: category.name,
            ));

    addRecipe(String name, String category, String ingredients, String steps) {
      var userId = ref.watch(userProvider).value!.uid;
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
        body: SingleChildScrollView(
            child: Container(
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
                              controller: categoryController,
                              label: const Text("Category:"),
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
                          child: Column(children: [
                            ...ingredientFieds,
                            ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    ingredientFieds.add(
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: TextField(
                                          controller: TextEditingController(),
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Ingredient',
                                              labelStyle: TextStyle(
                                                  color: hintTextColor)),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                label: const Text("new ingredient"))
                          ])),
                      Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(children: [
                            ...stepFieds,
                            ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    stepIndex += 1;
                                    stepFieds.add(
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(children: [
                                            Expanded(
                                                child: TextField(
                                              controller:
                                                  TextEditingController(),
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(),
                                                  labelText: '$stepIndex. step',
                                                  labelStyle: const TextStyle(
                                                      color: hintTextColor)),
                                            )),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: const Icon(
                                                    Icons.delete_forever)),
                                          ])),
                                    );
                                  });
                                },
                                label: const Text("new step"))
                          ])),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          onPressed: () {
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
                                  builder: (context) => CustomAlertDialog(
                                      pretext: "Adding failed"));
                            }
                          },
                          label: const Text("Add new recipe")),
                      const SizedBox(
                        height: 150,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.go("/");
                          },
                          child: const Text("Go home")),
                    ]))));
  }
}


/*
FutureBuilder<List<Widget>>(
                                future: ingredientFieds,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Widget>> snapshot) {
                                  List<Widget> children;
                                  if (snapshot.hasData) {
                                    children = <Widget>[
                                      Column(children: [...snapshot.data!]),
                                    ];
                                  } else if (snapshot.hasError) {
                                    children = <Widget>[
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text('Error: ${snapshot.error}'),
                                      ),
                                    ];
                                  } else {
                                    children = const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Loading categories...'),
                                      ),
                                    ];
                                  }
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: children,
                                    ),
                                  );
                                }),
*/
