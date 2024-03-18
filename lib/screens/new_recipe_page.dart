import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/textFields_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/screens/new_recipe_choose_category.dart';
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

  static const Color hintTextColor = Color(0xFF717571);
  late List<TextEditingController> ingredientTextFieldControllers;
  late List<TextEditingController> stepTextFieldControllers;
  final initialsStepsController = TextEditingController();
  final recipeNameController = TextEditingController();

  late final List<Widget> ingredientTextfieldWidgets = [
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: ref.watch(ingredientNotifierProvider)[0],
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Ingredient',
            labelStyle: TextStyle(color: hintTextColor)),
      ),
    ),
  ];
  var stepIndex = 1;
  late final List<Widget> stepTextFieldWidgets = [
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: ref.watch(stepNotifierProvider)[0],
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '1. step',
            labelStyle: TextStyle(color: hintTextColor)),
      ),
    ),
  ];

  @override
  build(BuildContext context) {
    ingredientTextFieldControllers = ref.watch(ingredientNotifierProvider);
    stepTextFieldControllers = ref.watch(stepNotifierProvider);
    //final user = ref.watch(userProvider);
    //final categories = ref.watch(categoryProvider);
    //List<TextEditingController> ingredientTextfieldControllers = [];
    // var dropownMenuItems = [
    //   DropdownMenuEntry<String>(
    //     value: "value",
    //     label: "value",
    //   )
    // ];
    // var dropownMenuItems =
    //     categories.map((category) => DropdownMenuEntry<String>(
    //           value: category.name,
    //           label: category.name,
    //         ));

    // Outdated: does not support multiple steps
    addRecipe(String name, String category, String ingredients, String steps) {
      var userId = ref.watch(userProvider).value!.uid;
      var mockId = idGenerator();
      var newRecipe = NewRecipe(
          userId: userId,
          id: mockId,
          name: name,
          categories: [category],
          ingredients: [ingredients],
          steps: [steps]);
      ref.watch(recipeProvider.notifier).addRecipe(newRecipe);
    }

    addNewRecipe() {
      var name = recipeNameController.value.text;
      List<String> steps = [];
      List<String> ingredients = [];
      for (var controller in ref.watch(ingredientNotifierProvider)) {
        ingredients.add(controller.value.text);
      }

      for (var controller in ref.watch(stepNotifierProvider)) {
        steps.add(controller.value.text);
      }
      var tempRecipe = NewRecipe(
          userId: ref.watch(userProvider).value!.uid,
          id: idGenerator(),
          name: name,
          steps: steps,
          ingredients: ingredients);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewRecipeCategoryPage(recipeWithoutCategories: tempRecipe)),
      );
    }

    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        margin: EdgeInsets.only(left: 30, top: 30),
        alignment: Alignment.bottomLeft,
        child: ElevatedButton.icon(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go("/");
            },
            label: const Text("Go back")),
      ),
      Center(
          child: Container(
              width: screenWidth > 800 ? screenWidth / 2 : screenWidth,
              margin: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Add a new recipe'),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                          controller: recipeNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              labelStyle: TextStyle(color: hintTextColor))),
                    ),
                    // Container( choosing a category from a dropdown:
                    //     margin: const EdgeInsets.only(
                    //         top: 10, left: 20, right: 20, bottom: 20),
                    //     child: Column(children: [
                    //       DropdownMenu(
                    //         controller: categoryController,
                    //         label: const Text("Category:"),
                    //         expandedInsets: EdgeInsets.zero,
                    //         dropdownMenuEntries: dropownMenuItems.toList(),
                    //         onSelected: (String? value) {
                    //           setState(() {
                    //             selectedCategory = value!;
                    //           });
                    //         },
                    //       ),
                    //     ])),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(children: [
                          ...ingredientTextfieldWidgets,
                          ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                var dynamicTextFieldController =
                                    TextEditingController();
                                ref
                                    .watch(ingredientNotifierProvider.notifier)
                                    .addContoller(dynamicTextFieldController);
                                setState(() {
                                  ingredientTextfieldWidgets.add(
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  dynamicTextFieldController,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Ingredient',
                                                  labelStyle: TextStyle(
                                                      color: hintTextColor)),
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(1),
                                              child: Icon(Icons.delete_forever))
                                        ])),
                                  );
                                });
                              },
                              label: const Text("new ingredient"))
                        ])),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(children: [
                          ...stepTextFieldWidgets,
                          ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                var dynamicTextFieldController2 =
                                    TextEditingController();
                                ref
                                    .watch(stepNotifierProvider.notifier)
                                    .addContoller(dynamicTextFieldController2);
                                setState(() {
                                  stepIndex += 1;
                                  stepTextFieldWidgets.add(
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(children: [
                                          Expanded(
                                              child: TextField(
                                            controller:
                                                dynamicTextFieldController2,
                                            decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText: '$stepIndex. step',
                                                labelStyle: const TextStyle(
                                                    color: hintTextColor)),
                                          )),
                                          Container(
                                              padding: const EdgeInsets.all(1),
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
                          if (recipeNameController.text.isNotEmpty) {
                            addNewRecipe();
                            for (var controller
                                in ref.watch(ingredientNotifierProvider)) {
                              print(controller.text);
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    CustomAlertDialog(title: "Adding failed"));
                          }
                        },
                        label: const Text("Continue")),
                    const SizedBox(
                      height: 150,
                    ),
                  ])))
    ])));
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
