import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/screens/trending_recipe.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(children: [
      const Text('Welcome!'),
      const Text('Today\'s Trending Recipe:'),
      Container(
          width: MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.all(10),
          child: Card(
            child: TrendingRecipe(),
          )),
      Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
              onPressed: () {
                context.go("/temp");
              },
              child: const Text("Go to category page"))),
    ])));
  }
}
