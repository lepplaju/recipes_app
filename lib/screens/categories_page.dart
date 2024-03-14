import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/category_provider.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends ConsumerState<CategoriesPage> {
  bool? showingRecipes;
  String? chosenRecipeName;
  double? screenWidth;

  @override
  build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    screenWidth = MediaQuery.of(context).size.width;

    List<Widget> customwidgets = categories.map((category) {
      return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: InkWell(
              onTap: () {
                //context.go('/category/${category.name.toLowerCase()}');
                setState(() {
                  chosenRecipeName = category.name;
                  showingRecipes = true;
                });
              },
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: Text(category.name))),
                        Container(
                            //     child: Placeholder(
                            //   child: Text("hello"),
                            //   color: Colors.blueGrey,
                            //   strokeWidth: 10,
                            //   fallbackHeight: 100,
                            //   fallbackWidth: 100,
                            // )
                            child: Image(
                                width: MediaQuery.of(context).size.width / 4,
                                image: AssetImage("assets/recepties_logo.png")))
                      ]))));
    }).toList();
    return Container(
        margin: EdgeInsets.all(20),
        child: screenWidth! < 800 &&
                showingRecipes != null &&
                showingRecipes == true
            ? showRecipe()
            : Row(children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(children: [
                              const Center(child: Text("Choose a category:")),
                              ...customwidgets,
                            ])))),
                showingRecipes != null && showingRecipes == true
                    ? showRecipe()
                    : SizedBox(),
              ]));
  }

  showRecipe() {
    return Center(
        child: Container(
            margin: EdgeInsets.all(10),
            width: screenWidth! / 3,
            child: Column(children: [
              Center(
                  child:
                      Text("Showing recipes with category: $chosenRecipeName")),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showingRecipes = false;
                    });
                  },
                  child: Text("close view"))
            ])));
  }
}
