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
    final screenWidth = MediaQuery.of(context).size.width;
    final double listingMargin = screenWidth > 1000 ? 200 : 50;

    List<Widget> customwidgets = categories.map((category) {
      return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: listingMargin),
          child: InkWell(
              onTap: () {
                context.go('/category/${category.name.toLowerCase()}');
              },
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: Text(category.name))),
                        Container(
                            //     child: Placeholder(
                            //   child: Text("hello"),
                            //   color: Colors.blueGrey,
                            //   strokeWidth: 10,
                            //   fallbackHeight: 100,
                            //   fallbackWidth: 100,
                            // )
                            child: Image(
                                width: MediaQuery.of(context).size.width / 4,
                                image: AssetImage("assets/recepties_logo.png")))
                      ]))));
    }).toList();
    return Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(children: [
              const Center(child: Text("Choose a category:")),
              ...customwidgets
            ])));
  }
}
