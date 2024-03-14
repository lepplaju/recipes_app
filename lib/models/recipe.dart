// the recipe name, the recipe ingredients, and the recipe steps
class Recipe {
  final String userId;
  final String id;
  String name;
  List<dynamic> ingredients;
  List<dynamic> steps;
  String category;

  Recipe(
      {required this.userId,
      required this.id,
      required this.name,
      required this.ingredients,
      required this.steps,
      this.category = ""});

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      userId: data["userId"],
      id: id,
      name: data["name"],
      ingredients: data["ingredients"],
      steps: data["steps"],
      category: data["category"],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      "category": category
    };
  }

  // Temporary solution to match the structure in Firebase
  // Map<String, dynamic> updateDataStructure() {
  //   return {
  //     "userId": userId,
  //     'id': id,
  //     'name': name,
  //     'ingredients': ingredients,
  //     'steps': steps,
  //     "categories": [category]
  //   };
  // }
}

// End of original recipe
// ------------------------------------------------------------
// Start of new recipe

class NewRecipe {
  final String userId;
  final String id;
  String name;
  List<dynamic> ingredients;
  List<dynamic> steps;
  List<dynamic> categories;

  NewRecipe({
    required this.userId,
    required this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    this.categories = const ["none"],
  });

  factory NewRecipe.fromFirestore(Map<String, dynamic> data, String id) {
    return NewRecipe(
      userId: data["userId"],
      id: id,
      name: data["name"],
      ingredients: data["ingredients"],
      steps: data["steps"],
      categories: data["categories"],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      "categories": categories
    };
  }

  Map<String, dynamic> updateDataStructure() {
    return {
      "userId": userId,
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      "categories": categories
    };
  }

  setRecipeCategories(NewRecipe recipeToChange, List<String> categories) {}
}
