import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/screens/navigation_example_page.dart';
import 'package:recipe_app/screens/recipe_page.dart';
import 'package:recipe_app/widgets/custom_top_bar.dart';

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
            return RecipePage();
          },
        ),
      ],
    ),
  ],
);

void main() {
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false, routerConfig: _router);
  }
}
