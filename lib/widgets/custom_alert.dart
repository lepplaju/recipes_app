import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/user_provider.dart';

class CustomAlertDialog extends ConsumerWidget {
  final String title;
  final String subtitle;

  CustomAlertDialog({super.key, required this.title, this.subtitle = ""});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: subtitle.length > 0 ? Text(subtitle) : null,
      actions: [
        TextButton(
          child: const Text("ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

// showNotification(BuildContext context) {
//   ref.watch(userProvider);
//   var text = 
//   AlertDialog dialog = AlertDialog(
//     title: Text("sup!"),
//     content: Text("data"),
//     actions: [
//       TextButton(
//         child: Text("yes"),
//         onPressed: () {},
//       ),
//     ],
//   );

//   showDialog(context: context, builder: (BuildContext context) => dialog);
