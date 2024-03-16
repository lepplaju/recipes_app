import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/debug_provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/widgets/custom_alert.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var user = ref.watch(userProvider);
    var allRecipes = ref.watch(recipeProvider);
    var yourRecipes =
        allRecipes.where((recipe) => recipe.userId == user.value!.uid);

    //var userFavoriteIds = ref.watch(favoritesProvider.notifier).getUserFavorites("admin");

    //print("user favorites: $userFavoriteIds");
    //List<Widget> favoriteRecipes = [];
    //List<Widget> favoriteRecipes =
    //   userFavoriteIds.map((recipeId) => Text("recipeId: $recipeId")).toList();
    List<Widget> recipeCards = yourRecipes
        .map((recipe) => Card(
            child: Container(
                width: screenWidth / 3,
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Center(child: Text(recipe.name))),
                      IconButton(
                          onPressed: () {
                            print("todo edit");
                          },
                          icon: Icon(Icons.edit)),
                    ]))))
        .toList();

    return Container(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
            child: Center(
                child: Container(
                    padding: EdgeInsets.only(top: 25),
                    child: Column(children: [
                      const Text("your recipes:"),
                      Container(
                        margin: EdgeInsets.all(25),
                        child: yourRecipes.isEmpty
                            ? const SizedBox(height: 100)
                            : Column(children: recipeCards),
                      ),
                      ElevatedButton(
                        child: const Text("add recipe"),
                        onPressed: () {
                          context.go("/newRecipe");
                        },
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      const Text("your favorite recipes:"),
                      FutureBuilder(
                          future: ref
                              .watch(favoritesProvider.notifier)
                              .getUserFavorites("admin"),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show a loading indicator while waiting for the future to complete
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Show an error message if the future fails
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Use the data from the future to build your UI
                              final userFavorites = snapshot.data;
                              print("user favorites: $userFavorites");
                              final snapshotwidgets = userFavorites!
                                  .map((rId) => Card(
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text("id: $rId"))))
                                  .toList();
                              // Return your UI widget using the userFavorites
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapshotwidgets);
                            }
                          }),
                      SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            logout();
                            showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                      title: "Logged out",
                                    ));
                          },
                          child: Text("Log out"))
                    ])))));
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
