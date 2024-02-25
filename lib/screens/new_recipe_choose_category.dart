import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/category_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';

class NewRecipeCategoryPage extends ConsumerStatefulWidget {
  @override
  NewRecipeCategoryPageState createState() => NewRecipeCategoryPageState();
}

class NewRecipeCategoryPageState extends ConsumerState<NewRecipeCategoryPage> {
  List<Widget> chosenCategories = [];
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var categories = ref.watch(categoryProvider);
    List<DropdownMenuEntry<String>> dropDownItems = categories
        .where((category) => !chosenCategories.contains(category))
        .toList()
        .map((e) => DropdownMenuEntry(value: e, label: e))
        .toList();

    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Choose the categories for the recipe"),
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                child: DropdownMenu(
                  dropdownMenuEntries: dropDownItems,
                  expandedInsets: EdgeInsets.zero,
                ))),
        Container(
            child: ElevatedButton.icon(
                onPressed: () {}, icon: Icon(Icons.add), label: Text("add")))
      ]),
      ElevatedButton.icon(
        label: Text("Create a new category"),
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
      ElevatedButton.icon(
        label: Text("Add another category"),
        icon: Icon(Icons.add),
        onPressed: () {},
      )
    ])));
  }
}
