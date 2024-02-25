import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/mock_data.dart';
import 'package:recipe_app/models/recipe.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text('Welcome!'),
      const Text('Today\'s Trending Recipe:'),
      Card(
        child: Text("TODO TRENDING"),
      ),
      Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
              onPressed: () {
                context.go("/temp");
              },
              child: Text("Go to category page"))),
    ]));
  }
}
