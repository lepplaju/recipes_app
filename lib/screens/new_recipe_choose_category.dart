import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class NewRecipeCategoryPage extends ConsumerStatefulWidget {
  @override
  NewRecipeCategoryPageState createState() => NewRecipeCategoryPageState();
}

class NewRecipeCategoryPageState extends ConsumerState<NewRecipeCategoryPage> {
  List<String> chosenCategories = [];
  bool showingTextField = false;
  TextEditingController newCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var selectedText = "";
    var user = ref.watch(userProvider);
    var categories = ref.watch(categoryProvider);
    List<DropdownMenuEntry<String>> dropDownItems = categories
        .where((category) => !chosenCategories.contains(category.name))
        .toList()
        .map((e) => DropdownMenuEntry(value: e.name, label: e.name))
        .toList();

    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Choose the categories for the recipe"),
      Container(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: DropdownMenu(
                      onSelected: (value) => selectedText = value!,
                      leadingIcon: Icon(Icons.search),
                      dropdownMenuEntries: dropDownItems,
                      expandedInsets: EdgeInsets.zero,
                    ))),
            Container(
                child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        // ONLY 3 CATEGORIES MAX PER RECIPE
                        if (selectedText.isNotEmpty) {
                          chosenCategories.add(selectedText);
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text("add")))
          ])),
      Container(
        margin: EdgeInsets.only(top: 50),
        child: ElevatedButton.icon(
          label:
              !showingTextField ? Text("Create a new category") : Text("Close"),
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              showingTextField = !showingTextField;
            });
          },
        ),
      ),
      showingTextField == false
          ? SizedBox(
              width: 0,
            )
          : Row(children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: newCategoryController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name the new category',
                        ),
                      ))),
              Container(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        print(newCategoryController.text);
                      },
                      icon: Icon(Icons.add),
                      label: Text("Create")))
            ]),
      Container(
        margin: EdgeInsets.all(50),
        child: SizedBox(
            height: 100,
            width: 200,
            child: ListView(
                shrinkWrap: true,
                children: chosenCategories
                    .map((e) =>
                        Row(children: [Text(e), Icon(Icons.delete_forever)]))
                    .toList())),
      )
    ])));
  }
}
