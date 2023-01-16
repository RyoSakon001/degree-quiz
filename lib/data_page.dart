import 'package:degree_quiz/bloc/degree/degree_bloc.dart';
import 'package:degree_quiz/bloc/degree/degree_event.dart';
import 'package:degree_quiz/bloc/substance/substance_bloc.dart';
import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:degree_quiz/model/degree.dart';
import 'package:degree_quiz/model/substance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SubstanceBloc()),
        BlocProvider(create: (_) => DegreeBloc()),
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
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<SubstanceBloc, Substance>(
              builder: (context, substance) => Text(substance.formula,
                  style: Theme.of(context).textTheme.headline1),
            ),
            BlocBuilder<DegreeBloc, Degree>(
              builder: (context, degree) => Text(degree.name,
                  style: Theme.of(context).textTheme.headline1),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<SubstanceBloc>().add(SubstanceIncrementPressed());
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<DegreeBloc>().add(DegreeIncrementPressed());
            },
          ),
        ],
      ),
    );
  }
}
