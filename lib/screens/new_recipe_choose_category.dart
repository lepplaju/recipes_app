import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/widgets/custom_alert.dart';

class NewRecipeCategoryPage extends ConsumerStatefulWidget {
  NewRecipe recipeWithoutCategories;
  NewRecipeCategoryPage({super.key, required this.recipeWithoutCategories});

  @override
  NewRecipeCategoryPageState createState() => NewRecipeCategoryPageState();
}

class NewRecipeCategoryPageState extends ConsumerState<NewRecipeCategoryPage> {
  List<String> chosenCategories = [];
  bool showingTextField = false;
  TextEditingController newCategoryController = TextEditingController();
  TextEditingController categoryDropdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final NewRecipe recipeWithoutCategories = widget.recipeWithoutCategories;
    print(recipeWithoutCategories.name);
    var selectedText = "";
    //var user = ref.watch(userProvider);
    var categories = ref.watch(categoryProvider);
    List<DropdownMenuEntry<String>> dropDownItems = categories
        .where((category) => !chosenCategories.contains(category.name))
        .toList()
        .map((e) => DropdownMenuEntry(value: e.name, label: e.name))
        .toList();

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("current recipe:"),
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${recipeWithoutCategories.name}"),
                                Text(
                                    "Ingredients: ${recipeWithoutCategories.ingredients}"),
                                Text("Steps: ${recipeWithoutCategories.steps}")
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      const Text("Choose up to 3 categories for your recipe"),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: [
                            Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                        bottom: 10,
                                        right: 10),
                                    child: DropdownMenu(
                                      enableFilter: true,
                                      controller: categoryDropdownController,
                                      onSelected: (value) =>
                                          selectedText = value!,
                                      dropdownMenuEntries: dropDownItems,
                                      expandedInsets: EdgeInsets.zero,
                                    ))),
                            Container(
                                padding: const EdgeInsets.all(1),
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        // ONLY 3 CATEGORIES MAX PER RECIPE
                                        if (selectedText.isNotEmpty) {
                                          chosenCategories.add(selectedText);
                                          categoryDropdownController.clear();
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text("add")))
                          ])),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: ElevatedButton.icon(
                          label: !showingTextField
                              ? const Text("Create a new category")
                              : const Text("Close"),
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              showingTextField = !showingTextField;
                            });
                          },
                        ),
                      ),
                      showingTextField == false
                          ? const SizedBox(
                              width: 0,
                            )
                          : Row(children: [
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: TextField(
                                        controller: newCategoryController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Name the new category',
                                        ),
                                      ))),
                              Container(
                                  padding: const EdgeInsets.all(1),
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        if (newCategoryController
                                            .text.isEmpty) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomAlertDialog(
                                                    title: "Error",
                                                    subtitle:
                                                        "Invalid category",
                                                  ));
                                          return;
                                        }
                                        var name = newCategoryController.text;
                                        var newCategory =
                                            RecipeCategory(name: name);
                                        if (ref.watch(categoryProvider).any(
                                            (category) =>
                                                category.name.toLowerCase() ==
                                                newCategory.name
                                                    .toLowerCase())) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomAlertDialog(
                                                    title: "Error",
                                                    subtitle:
                                                        "Category already exists",
                                                  ));
                                          return;
                                        } else {
                                          ref
                                              .watch(categoryProvider.notifier)
                                              .addCategory(newCategory);
                                          newCategoryController.clear();
                                        }
                                      },
                                      icon: const Icon(Icons.add),
                                      label: const Text("Create")))
                            ]),
                      Container(
                        margin: const EdgeInsets.all(50),
                        child: SizedBox(
                            height: 100,
                            width: 200,
                            child: ListView(
                                shrinkWrap: true,
                                children: chosenCategories
                                    .map((e) => Row(children: [
                                          Text(e),
                                          const Icon(Icons.delete_forever)
                                        ]))
                                    .toList())),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            recipeWithoutCategories.categories =
                                chosenCategories;
                            ref
                                .watch(recipeProvider.notifier)
                                .addRecipe(recipeWithoutCategories);
                            context.go("/");
                            Timer.run(() {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                        title: "New Recipe created succesfully",
                                      ));
                            });
                          },
                          icon: Icon(Icons.check),
                          label: Text("Finish"))
                    ]))));
  }
}
