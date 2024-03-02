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

  Future<NewRecipe?> getRecipeById(String id) async {
    var firestoreRecipe =
        await _firestore.collection("recipes_collection").doc(id).get();
    return NewRecipe.fromFirestore(firestoreRecipe.data()!, firestoreRecipe.id);
  }

  Future<NewRecipe?> fetchRandomTrending({String? previousId}) async {
    var randomkey = _firestore.collection("recipes_collection").doc().id;
    final recipeRef = _firestore.collection("recipes_collection");
    var query = recipeRef.where("id", isGreaterThan: previousId).limit(1);
    if (previousId != null) {
      query = recipeRef
          .where("id", isGreaterThan: randomkey)
          .where("id", isNotEqualTo: previousId)
          .limit(1);
    }

    var recipeSnapshot = await query.get();
    if (recipeSnapshot.docs.isNotEmpty) {
      var recipeData = recipeSnapshot.docs.first.data();
      return NewRecipe.fromFirestore(recipeData, recipeSnapshot.docs.first.id);
    } else {
      var secondRecipeSnapshot = await _firestore
          .collection("recipe_collection")
          .where("id", isGreaterThanOrEqualTo: randomkey)
          .where("id", isNotEqualTo: previousId)
          .orderBy("id")
          .limit(1)
          .get();
      if (secondRecipeSnapshot.docs.isNotEmpty) {
        var recipeData = recipeSnapshot.docs.first.data();
        return NewRecipe.fromFirestore(
            recipeData, recipeSnapshot.docs.first.id);
      } else {
        print("both empty!!!");
      }
      return null;
    }

    // if (recipeRef == null){
    // recipeRef = _firestore.collection("recipe_collection").where("id", isLessThanOrEqualTo: key).orderBy("id").limit(1);
    // }
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
