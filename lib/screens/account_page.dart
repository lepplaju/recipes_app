import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Column(children: [
      ElevatedButton(
        child: Text("add recipe"),
        onPressed: () {
          context.go("/newRecipe");
        },
      ),
      Text("your recipes:"),
      SizedBox(
        height: 100,
      ),
      Text("your favorites:")
    ]));
  }
}
