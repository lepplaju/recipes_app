import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/providers/user_provider.dart';

class FirebaseFavorite {}

class FavoriteNotifier extends StateNotifier<List<String>> {
  FavoriteNotifier() : super([]);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserFavorites(String userIdParam) async {
    final snapshot = await _firestore
        .collection("user_favorites")
        .where("userId", isEqualTo: userIdParam)
        .get();
    final map = snapshot.docs.first.data();
    List<String> favoriteRecipeIds = List<String>.from(map['recipes'] as List);
    final List<String> recipeIdStrings =
        favoriteRecipeIds.map((dynamId) => dynamId.toString()).toList();
    return recipeIdStrings;
  }

  addFavoriteToUser(String userIdParam, String recipeId) async {
    print("inside provider $userIdParam , $recipeId");
    final snapshot = await _firestore
        .collection("user_favorites")
        .where("userId", isEqualTo: userIdParam)
        .get();
    print("size: ${snapshot.size}");
    if (snapshot.docs.isEmpty) {
      print("user has no favorites");
      final newUserData = ({
        "userId": userIdParam,
        "recipes": [recipeId]
      });
      _firestore.collection("user_favorites").add(newUserData);
      print("user added");
      return null;
    } else {
      var map = snapshot.docs.firstOrNull;
      var mapdata = map!.data();
      List<String> favoriteRecipeIds =
          List<String>.from(map['recipes'] as List);
      if (favoriteRecipeIds.contains(recipeId)) {
        print("This recipe already in favorites");
        return null;
      } else {
        print(map.id);
        var currentrecipeIds = map["recipes"];
        print(currentrecipeIds);
        _firestore.collection("user_favorites").doc(map.id).update({
          "recipes": [...currentrecipeIds, recipeId]
        });
      }
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoriteNotifier, List<String>>(
    (ref) => FavoriteNotifier());
