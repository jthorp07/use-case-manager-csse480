import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/firebase_options.dart';
import 'package:use_case_manager/pages/base_page.dart';
import 'package:use_case_manager/pages/page_outline.dart';
import 'package:use_case_manager/pages/use_case_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Use Case Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: UCMColorScheme.roseRed,
            primary: UCMColorScheme.roseRed,
            secondary: UCMColorScheme.lightGray,
            tertiary: UCMColorScheme.white),
        useMaterial3: true,
      ),
      initialRoute: "/landing",
      routes: {
        "/landing": (c) => const BasePage(),
      },
    );
  }
}
