import 'package:degree_quiz/data_page.dart';
import 'package:degree_quiz/game_page.dart';
import 'package:degree_quiz/home_page.dart';
import 'package:degree_quiz/tutorial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/': (context) => const HomePage(),
        '/tutorial': (context) => TutorialPage(),
        '/game': (context) => GamePage(),
        '/data': (context) => DataPage(),
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
