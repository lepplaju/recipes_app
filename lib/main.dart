import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/screens/category_sceen.dart';
import 'package:recipe_app/screens/navigation_example_page.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const NavigationExample();
      },
      routes: [
        GoRoute(
          path: 'recipe/:name',
          builder: (BuildContext context, GoRouterState state) {
            return RecipeScreen(name: state.pathParameters['name']!);
          },
        ),
        GoRoute(
          path: 'category/:category',
          builder: (BuildContext context, GoRouterState state) {
            return CategoryPage(category: state.pathParameters['category']!);
          },
        ),
      ],
    ),
  ],
);

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final snapshot = await _firestore.collection('recipes_collection').get();
  // snapshot.docs.forEach((doc) => print('${doc.id}: ${doc.data()}'));

  runApp(ProviderScope(child: StartApp()));
}

class StartApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return MaterialApp(
    //     title: 'Recipe with login',
    //     home: user.when(
    //       data: (user) {
    //         return user == null ? LoginScreen() : NavigationExample();
    //       },
    //       error: (error, stackTrace) {
    //         return const Center(child: Text("Something went wrong.."));
    //       },
    //       loading: () {
    //         return const Center(child: Text("Loading..."));
    //       },
    //     ));

    return MaterialApp.router(
        debugShowCheckedModeBanner: false, routerConfig: _router);
  }
}
