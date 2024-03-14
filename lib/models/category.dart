class RecipeCategory {
  final String name;
  final String imageUrl;
  final String userId;

  RecipeCategory(
      {required this.name, this.userId = "none", this.imageUrl = "null"});

  Map<String, dynamic> toFirestore() {
    return {"name": name, "userId": userId};
  }

  factory RecipeCategory.fromFirestore(Map<String, dynamic> data) {
    return RecipeCategory(userId: data["userId"], name: data["name"]);
  }

  // One time use only to update existing data in Firebase:
  // Map<String, dynamic> updateDataStructure() {
  //   return {"name": name, "userId": userId, "imageUrl:": "null"};
  // }
}
