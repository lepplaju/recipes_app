import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/category_provider.dart';

class DebugPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: Container(
                margin: EdgeInsets.all(20),
                child: Column(children: [
                  Text("Temporary page for debugging"),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        print("Nothing happens");
                      },
                      child: Text("No method attached")),
                ]))));
  }
}
