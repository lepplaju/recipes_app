import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/models/recipe.dart';
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
    List<NewRecipe> userRecipes = [];

    //var userFavoriteIds = ref.watch(favoritesProvider.notifier).getUserFavorites("admin");

    //print("user favorites: $userFavoriteIds");
    //List<Widget> favoriteRecipes = [];
    //List<Widget> favoriteRecipes =
    //   userFavoriteIds.map((recipeId) => Text("recipeId: $recipeId")).toList();
    List<Widget> recipeCards = userRecipes
        .map((recipe) => Card(
            child: Container(
                width: screenWidth / 3,
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Center(child: Text(recipe.name))),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              print("todo edit");
                            },
                            icon: Icon(Icons.edit)),
                      )
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
                      FutureBuilder(
                          future: ref
                              .watch(recipeProvider.notifier)
                              .getUserRecipes(user.value!.uid),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<NewRecipe>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userRecipes = snapshot.data;
                              print("user created recipes: $userRecipes");
                              final snapshotwidgets = userRecipes!
                                  .map((recipe) => Card(
                                      child: Container(
                                          width: screenWidth / 3,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                    child: Center(
                                                        child:
                                                            Text(recipe.name))),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        print("todo edit");
                                                      },
                                                      icon: Icon(Icons.edit)),
                                                )
                                              ]))))
                                  .toList();
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapshotwidgets);
                            }
                          }),
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
                              .getUserFavorites(user.value!.uid),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userFavoritesAsId = snapshot.data;
                              return FutureBuilder(
                                  future: Future.wait(userFavoritesAsId!.map(
                                      (rId) => ref
                                          .watch(recipeProvider.notifier)
                                          .getRecipeById(rId))),
                                  builder: (context,
                                      AsyncSnapshot<List<NewRecipe?>>
                                          recipeSnapshot) {
                                    if (recipeSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (recipeSnapshot.hasError) {
                                      return Text(
                                          'Error: ${recipeSnapshot.error}');
                                    } else {
                                      List<NewRecipe?> recipes =
                                          recipeSnapshot.data!;
                                      List<Widget> favoritesWidgets = recipes
                                          .map((e) => Card(
                                              child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(e!.name))))
                                          .toList();
                                      return Column(
                                        children: favoritesWidgets,
                                      );
                                    }
                                  });
                            }
                          }),
                      // })
                      //                     print("user favorites: $userFavoritesAsId");
                      //                     final asRecipes = userFavoritesAsId!.map((rId) {return ref.watch(recipeProvider.notifier).getRecipeById(rId); }).toList();
                      //                     final snapshotwidgets = asRecipes
                      //                         .map((recipe) => Card(
                      //                             child: Container(
                      //                                 padding: EdgeInsets.all(5),
                      //                                 child: Text("id: ${recipe.name}"))))
                      //                         .toList();
                      //                     // Return your UI widget using the userFavorites
                      //                     return Column(
                      //                         crossAxisAlignment: CrossAxisAlignment.start,
                      //                         children: snapshotwidgets);
                      //                   }

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
