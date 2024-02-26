import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text('Welcome!'),
      const Text('Today\'s Trending Recipe:'),
      const Card(
        child: Text("TODO TRENDING"),
      ),
      Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
              onPressed: () {
                context.go("/temp");
              },
              child: const Text("Go to category page"))),
    ]));
  }
}
