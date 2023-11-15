import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/login_button.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/model/login_argument.dart';

class EmailAuthPage extends StatefulWidget {
  final LoginArgument isSignUp;
  const EmailAuthPage({
    super.key,
    required this.isSignUp,
  });

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  //UniqueKey? _loginUniqueKey;

  @override
  void initState() {
    emailTextController.text = "";
    passwordTextController.text = "";
    // _loginUniqueKey = AuthManager.instance.addLoginObserver(() {
    //   Navigator.of(context).popUntil((route) => route.isFirst);
    // });
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    // AuthManager.instance.removeObserver(_loginUniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailTextController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !EmailValidator.validate(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: UCMColorScheme.white)),
                labelText: "Email",
                hintText: "Enter an email address",
                labelStyle: TextStyle(color: UCMColorScheme.white),
                hintStyle: TextStyle(color: UCMColorScheme.white),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordTextController,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Passwords in Firebase must be at least 6 characters";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Passwords must be 6 characters or more",
                labelStyle: TextStyle(color: UCMColorScheme.white),
                hintStyle: TextStyle(color: UCMColorScheme.white),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            LoginButton(
              text: widget.isSignUp.signUp ? "Create an account" : "Log in",
              clickCallback: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isSignUp.signUp) {
                    AuthManager.instance.createUserWithEmailPassword(
                      context: context,
                      emailAddress: emailTextController.text,
                      password: passwordTextController.text,
                    );
                  } else {
                    AuthManager.instance.loginExistingUserWithEmailPassword(
                      context: context,
                      emailAddress: emailTextController.text,
                      password: passwordTextController.text,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid form entry")),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
