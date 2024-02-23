import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/category_provider.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  build(BuildContext context, WidgetRef ref) {
    //List<String> categories = MockRecipeData().getCategories();

    final categories = ref.watch(categoryProvider);

    List<Widget> customwidgets = categories.map((category) {
      return InkWell(
          onTap: () {
            context.go('/category/${category.toLowerCase()}');
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
