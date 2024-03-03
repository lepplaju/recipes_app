import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingRecipe extends ConsumerStatefulWidget {
  TrendingRecipeState createState() => TrendingRecipeState();
}

class TrendingRecipeState extends ConsumerState<TrendingRecipe> {
  late final int savedDay;

  // Get a random recipe based on the date
  Future<NewRecipe?> fetchTrendingRecipe() async {
    var prefs = await SharedPreferences.getInstance();
    int temp = (DateTime.now().day + DateTime.now().year);
    int savedDay = prefs.getInt("savedDay") ?? temp;
    if (savedDay != temp) {
      var newTrendingId = await ref
          .watch(recipeProvider.notifier)
          .fetchRandomTrending(previousId: prefs.getString("trendingDocId"))
          .then((value) => value!.id);
      prefs.setString("trendingDocId", newTrendingId);
    }
    String savedDocId = prefs.getString("trendingDocId") ??
        await ref
            .watch(recipeProvider.notifier)
            .fetchRandomTrending()
            .then((value) => value!.id);

    NewRecipe? trendingRecipe =
        await ref.watch(recipeProvider.notifier).getRecipeById(savedDocId);
    return trendingRecipe;
  }

  @override
  build(BuildContext context) {
    return FutureBuilder(
      future: fetchTrendingRecipe(),
      builder: (context, AsyncSnapshot<NewRecipe?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // or any loading indicator
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        final NewRecipe trendingRecipe = snapshot.data!;
        return Center(
            child: Container(
                child: Column(
                    children: [Text("recipe name: ${trendingRecipe.name}")])));
      },
    );
  }
}
