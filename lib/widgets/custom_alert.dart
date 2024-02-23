import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/providers/user_provider.dart';

class CustomAlertDialog extends ConsumerWidget {
  String pretext;
  CustomAlertDialog({this.pretext = "sign in"});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var textToDisplay =
        user.value != null ? "$pretext succesful!" : "$pretext failed!";
    return AlertDialog(
      title: Text(textToDisplay),
      actions: [
        TextButton(
          child: Text("ok"),
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
