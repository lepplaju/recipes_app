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

  void addCategoryWithString(String category) async {
    var categoryData =
        RecipeCategory(name: category, userId: "none").toFirestore();
    await _firestore.collection('categories').add(categoryData);
    final addedCategory = RecipeCategory.fromFirestore(categoryData);
    state = [...state, addedCategory];
  }

  void addCategory(RecipeCategory category) async {
    var categoryData =
        RecipeCategory(name: category.name, userId: category.userId)
            .toFirestore();
    await _firestore.collection('categories').add(categoryData);
    final addedCategory = RecipeCategory.fromFirestore(categoryData);
    state = [...state, addedCategory];
  }

  // One time method used to add image to the data structure in Firebase
  // Future modifyDataStructure() async {
  //   print("start of modification");
  //   var snapshot = await _firestore.collection('categories').get();
  //   final categories = snapshot.docs.map((doc) {
  //     return {doc.id: RecipeCategory.fromFirestore(doc.data())};
  //   });

  //   categories.forEach((categoryMap) {
  //     print(categoryMap);
  //     categoryMap.forEach((categoryId, category) {
  //       _firestore.collection('categories').doc(categoryId).update({
  //         "imageUrl": "null",
  //       });
  //     });
  //   });
  //   return false;
  // }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<RecipeCategory>>(
        (ref) => CategoryNotifier());
