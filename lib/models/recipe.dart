// the recipe name, the recipe ingredients, and the recipe steps
class Recipe {
  final String id;
  String name;
  List<dynamic> ingredients;
  List<dynamic> steps;
  String category;

  Recipe(
      {required this.id,
      required this.name,
      required this.ingredients,
      required this.steps,
      this.category = ""});

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      id: id,
      name: data["name"],
      ingredients: data["ingredients"],
      steps: data["steps"],
      category: data["category"],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      "category": category
    };
  }
}
