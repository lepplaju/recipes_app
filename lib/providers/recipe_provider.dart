import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeNotifier extends StateNotifier<List<NewRecipe>> {
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
      return NewRecipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = recipes;
  }

  void addRecipe(NewRecipe recipeToAdd) async {
    // if (userId == '') {
    //   return;
    // }

    // final noteRef =
    //     await _firestore.collection('recipes_collection').add(recipe);
    // final note = Recipe.fromFirestore(recipe, noteRef.id);
    // state = [...state, note];

    final recipeData = NewRecipe(
      userId: recipeToAdd.userId,
      id: recipeToAdd.id,
      name: recipeToAdd.name,
      categories: recipeToAdd.categories,
      ingredients: recipeToAdd.ingredients,
      steps: recipeToAdd.steps,
    ).toFirestore();

    final recipeRef =
        await _firestore.collection('recipes_collection').add(recipeData);
    final recipe = NewRecipe.fromFirestore(recipeData, recipeRef.id);
    state = [...state, recipe];
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes_collection').doc(id).delete();
    state = state.where((recipe) => recipe.id != id).toList();
  }

// Temporary function used to modify the data structure in firebase
/*
  void updateAllRecipes() async {
    var snapshot = await _firestore.collection('recipes_collection').get();
    final recipes = snapshot.docs.map((doc) {
      return Recipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    recipes.forEach((recipee) {
      {
        _firestore.collection('recipes_collection').doc(recipee.id).update({
          "categories": [recipee.category],
          "category": FieldValue.delete()
        });
      }
    });
  }
  */

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

final recipeProvider = StateNotifierProvider<RecipeNotifier, List<NewRecipe>>(
    (ref) => RecipeNotifier());
