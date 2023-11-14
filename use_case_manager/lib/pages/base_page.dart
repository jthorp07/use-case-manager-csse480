import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/model/login_argument.dart';
import 'package:use_case_manager/pages/email_auth_page.dart';
import 'package:use_case_manager/pages/landing_page.dart';
import 'package:use_case_manager/pages/page_outline.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  State<BasePage> createState() => _BasePageSate();
}

class _BasePageSate extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'landing/chooseLogin',
      onGenerateRoute: (RouteSettings settings) {
        Widget child;
        switch (settings.name) {
          case 'landing/chooseLogin':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            child = const UseCaseManagerLandingPage();
          case 'landing/email':
            // Assume ChooseCredentialsPage collects new credentials and then
            // invokes 'onSignupComplete()'.
            child =
                EmailAuthPage(isSignUp: settings.arguments as LoginArgument);
          case 'landing/google':
            child = SignInScreen(
              providers: [
                GoogleProvider(
                    clientId:
                        "firebase-adminsdk-mw3z5@thorpj-henderm-csse480.iam.gserviceaccount.com"),
              ],
              actions: [
                AuthStateChangeAction(
                  (context, state) {
                    if (state is SignedIn || state is UserCreated) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                )
              ],
            );
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        builder(BuildContext context) => PageOutline(child: child);
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
