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

  static List<Recipe> tempRecipeList = [
    Recipe(
      name: "Spaghetti Carbonara",
      ingredients: [
        "8 ounces spaghetti",
        "2 large eggs",
        "1/2 cup grated Parmesan cheese",
        "4 slices bacon, chopped",
        "2 cloves garlic, minced",
        "Salt and black pepper to taste",
        "Fresh parsley, chopped (for garnish)"
      ],
      steps: [
        "Cook spaghetti until al dente.",
        "Whisk eggs and Parmesan.",
        "Cook bacon and garlic until fragrant.",
        "Toss spaghetti with bacon mixture.",
        "Stir in egg mixture.",
        "Adjust consistency with pasta water.",
        "Season with salt and pepper.",
        "Garnish with parsley."
      ],
      category: "Pasta & Noodles",
    ),
    Recipe(
      name: "Caesar Salad",
      ingredients: [
        "1 head romaine lettuce, chopped",
        "1/2 cup Caesar salad dressing",
        "1/4 cup grated Parmesan cheese",
        "1 cup croutons",
        "1 lemon, juiced",
        "2 cloves garlic, minced",
        "Salt and black pepper to taste"
      ],
      steps: [
        "Combine lettuce and croutons.",
        "Whisk dressing, lemon, garlic, salt, and pepper.",
        "Pour dressing over salad.",
        "Sprinkle with Parmesan.",
        "Serve immediately."
      ],
      category: "Salads & Dressings",
    ),
    Recipe(
      name: "Chicken Stir-Fry with Vegetables",
      ingredients: [
        "2 boneless, skinless chicken breasts, thinly sliced",
        "2 cups mixed vegetables (bell peppers, broccoli, carrots, snap peas, etc.), sliced",
        "3 tablespoons soy sauce",
        "2 tablespoons oyster sauce",
        "1 tablespoon sesame oil",
        "2 cloves garlic, minced",
        "1 teaspoon grated ginger",
        "2 tablespoons vegetable oil",
        "Cooked rice, for serving"
      ],
      steps: [
        "Mix soy sauce, oyster sauce, sesame oil, garlic, and ginger.",
        "Sauté chicken until browned.",
        "Stir-fry vegetables.",
        "Return chicken to skillet.",
        "Add sauce and cook briefly.",
        "Serve over rice."
      ],
      category: "Poultry",
    ),
    Recipe(
      name: "Chocolate Chip Cookies",
      ingredients: [
        "2 1/4 cups all-purpose flour",
        "1 teaspoon baking soda",
        "1 cup unsalted butter, softened",
        "3/4 cup granulated sugar",
        "3/4 cup packed brown sugar",
        "1 teaspoon vanilla extract",
        "2 large eggs",
        "2 cups semisweet chocolate chips"
      ],
      steps: [
        "Preheat oven to 375°F (190°C).",
        "Cream butter, sugars, and vanilla.",
        "Beat in eggs.",
        "Mix in flour and baking soda.",
        "Stir in chocolate chips.",
        "Drop dough onto baking sheets.",
        "Bake for 9-11 minutes.",
        "Cool on wire racks."
      ],
      category: "Desserts & Sweets",
    ),
    Recipe(
      name: "Vegetable Lentil Soup",
      ingredients: [
        "1 cup dried green or brown lentils, rinsed",
        "1 onion, diced",
        "2 carrots, diced",
        "2 stalks celery, diced",
        "2 cloves garlic, minced",
        "6 cups vegetable broth",
        "1 can (14.5 ounces) diced tomatoes",
        "1 teaspoon dried thyme",
        "1 teaspoon dried oregano",
        "Salt and black pepper to taste",
        "2 cups chopped spinach or kale",
        "2 tablespoons olive oil"
      ],
      steps: [
        "Sauté onion, carrots, and celery.",
        "Add garlic, thyme, and oregano.",
        "Stir in lentils, broth, and tomatoes.",
        "Simmer until lentils are tender.",
        "Season with salt and pepper.",
        "Add spinach or kale and cook until wilted.",
        "Adjust seasoning if needed."
      ],
      category: "Soups & Stews",
    ),
  ];
}
