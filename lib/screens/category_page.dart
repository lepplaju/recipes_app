import 'package:flutter/material.dart';
import 'package:recipe_app/models/mock_data.dart';

class CategoriesPage extends StatelessWidget {
  @override
  build(BuildContext context) {
    List<String> categories = MockRecipeData().getCategories();

    List<Widget> customwidgets = categories.map((category) {
      return InkWell(
          onTap: () {
            print('todo');
          },
          child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                  padding: EdgeInsets.all(15), child: Text('$category'))));
    }).toList();
    return Center(
        child:
            ListView(children: [Text("Choose a category:"), ...customwidgets]));
  }
}
