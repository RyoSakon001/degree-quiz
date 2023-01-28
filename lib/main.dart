import 'package:degree_quiz/game_page.dart';
import 'package:degree_quiz/home_page.dart';
import 'package:degree_quiz/privacy_policy_page.dart';
import 'package:degree_quiz/terms_page.dart';
import 'package:degree_quiz/tutorial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/tutorial': (context) => TutorialPage(),
        '/game': (context) => GamePage(),
        '/terms_of_service': (context) => TermsPage(),
        '/privacy_policy': (context) => PrivacyPolicyPage(),
      },
      initialRoute: "/",
      title: 'Flutter Overboard Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
