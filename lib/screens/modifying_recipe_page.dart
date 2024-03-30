import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/textFields_provider.dart';

class ModifyingRecipe extends ConsumerStatefulWidget {
  final String recipeId;
  const ModifyingRecipe({super.key, required this.recipeId});
  @override
  ModifyingRecipeState createState() => ModifyingRecipeState();
}

class ModifyingRecipeState extends ConsumerState<ModifyingRecipe> {
  final nameController = TextEditingController();
  late final List<Widget> ingredientTextfieldWidgets = [];
  late final List<Widget> stepTextfieldWidgets = [];
  List<Widget> selectedCategoryWidgets = [];
  var stepindex = 0;
  List<String> chosenCategories = [];
  final categoryDropdownController = TextEditingController();
  List<DropdownMenuEntry<String>>? notSelectedDropDownItems;
  List<RecipeCategory> categories = [];
  var screenWidth = 0.0;
  var userModifications = true;

  makeTextFields(NewRecipe recipe) {
    if (userModifications = false) {
      return;
    }
    ingredientTextfieldWidgets.clear();
    for (var ingredient in recipe.ingredients) {
      var dynamicTextFieldController = TextEditingController();
      dynamicTextFieldController.text = ingredient;
      ingredientTextfieldWidgets.add(Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            Expanded(
                child: TextField(
                    controller: dynamicTextFieldController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingredient',
                    ))),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.delete_forever))
          ])));
    }
    stepTextfieldWidgets.clear();
    for (var step in recipe.steps) {
      stepindex += 1;
      var dynamicTextFieldController = TextEditingController();
      dynamicTextFieldController.text = step;
      stepTextfieldWidgets.add(Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            Expanded(
                child: TextField(
                    controller: dynamicTextFieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "$stepindex. step",
                    ))),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.delete_forever))
          ])));
    }
    userModifications = false;
  }

  makeCategories(NewRecipe recipe) {
    selectedCategoryWidgets = recipe.categories
        .map((e) => Row(children: [
              Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.delete_forever)),
              Text(e),
            ]))
        .toList();

    notSelectedDropDownItems = categories
        .where((category) => !chosenCategories.contains(category.name))
        .toList()
        .map((e) => DropdownMenuEntry(value: e.name, label: e.name))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    categories = ref.watch(categoryProvider);
    var recipeId = widget.recipeId;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
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
                    Text("modifying recipe with ID: $recipeId"),
                    FutureBuilder(
                        future: ref
                            .watch(recipeProvider.notifier)
                            .getRecipeById(recipeId),
                        builder: (BuildContext context,
                            AsyncSnapshot<NewRecipe?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error With id $recipeId : ${snapshot.error}');
                          } else {
                            final recipe = snapshot.data!;
                            nameController.text = recipe.name;
                            makeTextFields(recipe);
                            makeCategories(recipe);
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Recipe name',
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Ingredients:"),
                                  // TextField(
                                  //     controller: nameController,
                                  //     decoration: const InputDecoration(
                                  //       border: OutlineInputBorder(),
                                  //       labelText: 'Ingredients',
                                  //     )),
                                  ...ingredientTextfieldWidgets,
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Steps:"),
                                  ...stepTextfieldWidgets,
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Categories:"),
                                        ...selectedCategoryWidgets,
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            print("hello");
                                          },
                                          icon: Icon(Icons.add),
                                          label: Text("Add category"),
                                        )
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        print("todo saving");
                                      },
                                      child: Text("Save & Exit"))
                                ]);
                          }
                        }),
                  ])))
    ]))));
  }
}
