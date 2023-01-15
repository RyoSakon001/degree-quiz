import 'package:degree_quiz/bloc/app_bloc_observer.dart';
import 'package:degree_quiz/bloc/theme_cubit.dart';
import 'package:degree_quiz/counter_page.dart';
import 'package:degree_quiz/data_page.dart';
import 'package:degree_quiz/game_page.dart';
import 'package:degree_quiz/home_page.dart';
import 'package:degree_quiz/tutorial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          routes: {
            '/': (context) => const HomePage(),
            '/tutorial': (context) => TutorialPage(),
            '/game': (context) => GamePage(),
            '/data': (context) => DataPage(),
            '/counter': (context) => CounterPage(),
          },
          initialRoute: "/",
          title: 'Flutter Overboard Demo',
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }
}
