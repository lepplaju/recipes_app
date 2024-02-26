import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/category.dart';

class CategoryNotifier extends StateNotifier<List<RecipeCategory>> {
  CategoryNotifier() : super([]) {
    _fetchCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    final categories = snapshot.docs.map((doc) {
      return RecipeCategory.fromFirestore(doc.data());
    }).toList();
    state = categories;
  }

  void addCategory(String category) async {
    var categoryData =
        RecipeCategory(name: category, userId: "none").toFirestore();
    await _firestore.collection('categories').add(categoryData);
    final addedCategory = RecipeCategory.fromFirestore(categoryData);
    state = [...state, addedCategory];
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<RecipeCategory>>(
        (ref) => CategoryNotifier());
