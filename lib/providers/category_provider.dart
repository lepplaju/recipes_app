import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/models/recipe.dart';

class CategoryNotifier extends StateNotifier<List<String>> {
  CategoryNotifier() : super([]) {
    _fetchCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    final categories = snapshot.docs.map((doc) {
      return doc.data()['name'].toString();
    }).toList();
    state = categories;
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>(
    (ref) => CategoryNotifier());
