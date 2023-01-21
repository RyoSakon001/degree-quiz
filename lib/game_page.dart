import 'package:degree_quiz/bloc/degree/degree_bloc.dart';
import 'package:degree_quiz/bloc/question/question_bloc.dart';
import 'package:degree_quiz/bloc/question/question_event.dart';
import 'package:degree_quiz/bloc/substance/substance_bloc.dart';
import 'package:degree_quiz/model/degree.dart';
import 'package:degree_quiz/model/question.dart';
import 'package:degree_quiz/model/substance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SubstanceBloc()),
        BlocProvider(create: (_) => DegreeBloc()),
        BlocProvider(create: (_) => QuestionBloc()),
      ],
      child: const DataView(),
    );
  }
}

class DataView extends StatelessWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('戻る'),
                    ),
                    ElevatedButton(
                      onPressed: () => _showTerms(context),
                      child: Text('条件'),
                    ),
                  ],
                ),
                BlocBuilder<SubstanceBloc, Substance>(
                  builder: (context, substance) => Text(substance.formula,
                      style: Theme.of(context).textTheme.headline1),
                ),
                BlocBuilder<DegreeBloc, Degree>(
                  builder: (context, degree) => Text(degree.name,
                      style: Theme.of(context).textTheme.headline1),
                ),
                BlocBuilder<QuestionBloc, Question>(
                  builder: (context, question) => Text(question.sentence),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // context
                    //     .read<SubstanceBloc>()
                    //     .add(SubstanceIncrementPressed());
                    // context.read<DegreeBloc>().add(DegreeIncrementPressed());
                    context
                        .read<QuestionBloc>()
                        .add(QuestionIncrementPressed());
                  },
                  child: Text('問題を出す'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTerms(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        String text = '';
        text += '・アボガドロ定数は\n';
        text += '6.0 ✖︎ 10 ^ 23とする。\n';
        text += '・気体は理想気体とする。\n';
        text += '・標準状態とする。\n';
        text += '・原子量は以下の通り。\n\n';
        text += 'H = 1\n';
        text += 'C = 12\n';
        text += 'N = 14\n';
        text += 'O = 16\n';
        text += 'Na = 23\n';
        text += 'Mg = 24\n';
        text += 'Al = 27\n';
        text += 'S = 32\n';
        text += 'Ca = 40\n';
        return AlertDialog(
          title: Text('＜条件＞'),
          content: Text(text),
          actions: [
            ElevatedButton(
              child: const Text('プレイ画面に戻る'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
