import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/screens/navigation_example_page.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const NavigationExample();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'recipe',
          builder: (BuildContext context, GoRouterState state) {
            return RecipeScreen();
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final snapshot = await _firestore.collection('recipes_collection').get();
  // snapshot.docs.forEach((doc) => print('${doc.id}: ${doc.data()}'));

  runApp(ProviderScope(child: StartApp()));
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});
  @override
  Widget build(BuildContext context) {
    //  MaterialApp(title: 'recipeapp', home: NavigationExample());
    return MaterialApp.router(
        debugShowCheckedModeBanner: false, routerConfig: _router);
  }
}
