import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatelessWidget {
  String category;
  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CategoryScreen(category: category));
  }
}

class CategoryScreen extends ConsumerWidget {
  String category;

  CategoryScreen({required this.category});

  @override
  build(BuildContext context, WidgetRef ref) {
    print(category);
    return Center(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text('Go home')),
              Text('Showing recipies with category $category')
            ])));
  }
}
