import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:recipe_app/widgets/custom_alert.dart';

class LoginPage extends StatefulWidget {
  final String type;
  const LoginPage({super.key, required this.type});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  AutovalidateMode showValidationText = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final String type = widget.type;
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double textFieldWidth = (MediaQuery.of(context).size.width) / 4;
    String textAtTop = "Create account:";
    Icon buttonIcon = const Icon(Icons.account_circle_outlined);
    String buttonLabelText = "Create";
    //showValidationText = AutovalidateMode.disabled;
    if (type == 'login') {
      textAtTop = "Log in:";
      buttonIcon = const Icon(Icons.login);
      buttonLabelText = "Login";
    }
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Form(
                key: formkey,
                child: Column(children: [
                  Text(textAtTop),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        alignment: Alignment.center,
                        width: textFieldWidth,
                        child: const Text("email:")),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Colors.amberAccent),
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Email'),
                                    controller: usernameController,
                                    autovalidateMode: showValidationText,
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? "Enter a valid email"
                                        : null))))
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        width: textFieldWidth,
                        alignment: Alignment.center,
                        child: const Text("password:")),
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Colors.amberAccent),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  controller: passwordController,
                                  autovalidateMode: showValidationText,
                                  validator: (password) => password != null &&
                                          password.length < 5
                                      ? "Password length has to be 5 or longer"
                                      : null,
                                  obscureText: true,
                                ))))
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: buttonIcon,
                    label: Text(buttonLabelText),
                    onPressed: () {
                      _submit(usernameController.text, passwordController.text,
                          type);
                    },
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text("Cancel"),
                    onPressed: () {
                      context.pop();
                    },
                  )
                ]))));
  }

  Future _submit(String emailInput, String passwordInput, String type) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      showValidationText = AutovalidateMode.always;
      return;
    }
    if (type == 'create') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            return const Center(child: CircularProgressIndicator());
          }));
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailInput.trim(),
          password: passwordInput.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      if (!context.mounted) return;
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) =>
              const CustomAlertDialog(pretext: "Account creation"));
    } else if (type == "login") {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            return const Center(child: CircularProgressIndicator());
          }));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailInput, password: passwordInput);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          debugPrint('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          debugPrint('Wrong password provided for that user.');
        }
      }
      if (!context.mounted) return;
      Navigator.of(context).pop();
      showDialog(
          context: context, builder: (context) => const CustomAlertDialog());
    }
  }
}
