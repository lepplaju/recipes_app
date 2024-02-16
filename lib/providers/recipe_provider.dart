import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeNotifier extends StateNotifier<List<Recipe>> {
  // final String userId;
  // {required this.userId}

  RecipeNotifier() : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    // if (userId == '') {
    //   return;
    // }
    // .where('userId', isEqualTo: userId)
    final snapshot = await _firestore.collection('recipes_collection').get();
    final recipes = snapshot.docs.map((doc) {
      return Recipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = recipes;
  }

  void addRecipe(Recipe recipeToAdd) async {
    // if (userId == '') {
    //   return;
    // }

    // final noteRef =
    //     await _firestore.collection('recipes_collection').add(recipe);
    // final note = Recipe.fromFirestore(recipe, noteRef.id);
    // state = [...state, note];

    final recipeData = Recipe(
      id: recipeToAdd.id,
      name: recipeToAdd.name,
      category: recipeToAdd.category,
      ingredients: recipeToAdd.ingredients,
      steps: recipeToAdd.steps,
    ).toFirestore();

    final recipeRef =
        await _firestore.collection('recipes_collection').add(recipeData);
    final recipe = Recipe.fromFirestore(recipeData, recipeRef.id);
    state = [...state, recipe];
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes_collection').doc(id).delete();
    state = state.where((recipe) => recipe.id != id).toList();
  }

  //   final asyncUser = ref.watch(userProvider);
  //   return asyncUser.when(data: (user) {
  //     return NoteNotifier(userId: user!.uid);
  //   }, loading: () {
  //     return NoteNotifier(userId: '');
  //   }, error: (error, stackTrace) {
  //     return NoteNotifier(userId: '');
  //   });
  // });
}

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<Recipe>>(
    (ref) => RecipeNotifier());
