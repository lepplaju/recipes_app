import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  build(BuildContext context) {
    List<String> categories = MockRecipeData().getCategories();

    List<Widget> customwidgets = categories.map((category) {
      return InkWell(
          onTap: () {
            print('todo');
          },
          child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                  padding: const EdgeInsets.all(15), child: Text(category))));
    }).toList();
    return Center(
        child: ListView(
            children: [const Text("Choose a category:"), ...customwidgets]));
  }
}
