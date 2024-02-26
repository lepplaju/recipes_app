class RecipeCategory {
  final String name;
  final String userId;

  RecipeCategory({required this.name, this.userId = "none"});

  Map<String, dynamic> toFirestore() {
    return {"name": name, "userId": userId};
  }

  factory RecipeCategory.fromFirestore(Map<String, dynamic> data) {
    return RecipeCategory(userId: data["userId"], name: data["name"]);
  }
}
