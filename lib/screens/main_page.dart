import 'package:flutter/material.dart';
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
      )
    ]));
  }
}
