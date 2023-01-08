import 'package:degree_quiz/home_page.dart';
import 'package:degree_quiz/tutorial_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        '/tutorial': (context) => TutorialPage(),
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
