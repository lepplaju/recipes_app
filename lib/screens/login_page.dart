import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:recipe_app/providers/user_provider.dart';
import 'package:recipe_app/widgets/custom_alert.dart';

class LoginPage extends StatefulWidget {
  final String type;
  const LoginPage({required this.type});

  _LoginPageState createState() => _LoginPageState(type: type);
}

class _LoginPageState extends State<LoginPage> {
  final String type;
  final formkey = GlobalKey<FormState>();
  AutovalidateMode showValidationText = AutovalidateMode.disabled;
  _LoginPageState({required this.type});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double textFieldWidth = (MediaQuery.of(context).size.width) / 4;
    String textAtTop = "Create account:";
    Icon buttonIcon = Icon(Icons.account_circle_outlined);
    String buttonLabelText = "Create";
    //showValidationText = AutovalidateMode.disabled;
    if (type == 'login') {
      textAtTop = "Log in:";
      buttonIcon = Icon(Icons.login);
      buttonLabelText = "Login";
    }
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(10),
            child: Form(
                key: formkey,
                child: Column(children: [
                  Text(textAtTop),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        alignment: Alignment.center,
                        width: textFieldWidth,
                        child: Text("email:")),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.amberAccent),
                                child: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                    controller: usernameController,
                                    autovalidateMode: showValidationText,
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? "Enter a valid email"
                                        : null))))
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        width: textFieldWidth,
                        alignment: Alignment.center,
                        child: Text("password:")),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 30),
                            child: DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.amberAccent),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Password'),
                                  controller: passwordController,
                                  autovalidateMode: showValidationText,
                                  validator: (password) => password != null &&
                                          password.length < 5
                                      ? "Password length has to be 5 or longer"
                                      : null,
                                  obscureText: true,
                                ))))
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: buttonIcon,
                    label: Text(buttonLabelText),
                    onPressed: () {
                      _submit(usernameController.text, passwordController.text);
                    },
                  ),
                  SizedBox(height: 100),
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back_rounded),
                    label: Text("Cancel"),
                    onPressed: () {
                      context.pop();
                    },
                  )
                ]))));
  }

  Future _submit(String emailInput, String passwordInput) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      showValidationText = AutovalidateMode.always;
      return;
    }
    BuildContext dialogContext;
    if (type == 'create') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            dialogContext = context;
            return Center(child: CircularProgressIndicator());
          }));
      try {
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailInput.trim(),
          password: passwordInput.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(pretext: "Account creation"));
    } else if (type == "login") {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            dialogContext = context;
            return Center(child: CircularProgressIndicator());
          }));
      try {
        final credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailInput, password: passwordInput);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      Navigator.of(context).pop();
      showDialog(context: context, builder: (context) => CustomAlertDialog());
    }
  }
}
