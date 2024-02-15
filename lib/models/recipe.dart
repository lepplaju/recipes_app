// the recipe name, the recipe ingredients, and the recipe steps.
class Recipe {
  String name;
  List<String> ingredients;
  List<String> steps;
  String category;

  Recipe(
      {required this.name,
      required this.ingredients,
      required this.steps,
      this.category = ''});
}
