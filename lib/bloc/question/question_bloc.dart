import 'dart:math';

import 'package:degree_quiz/bloc/question/question_event.dart';
import 'package:degree_quiz/firestore_provider.dart';
import 'package:degree_quiz/model/degree.dart';
import 'package:degree_quiz/model/substance.dart';
import 'package:degree_quiz/model/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBloc extends Bloc<QuestionEvent, Question> {
  QuestionBloc()
      : super(Question(
            substance: Substance(
              id: 0,
              formula: '',
              amount: 1,
              commonName: '',
            ),
            givenRate: 1,
            givenDegree: Degree(
              type: 0,
              name: '',
              degree: '',
              baseValue: 1,
            ),
            desiredDegree: Degree(
              type: 0,
              name: '',
              degree: '',
              baseValue: 1,
            ),
            answer: 1)) {
    on<QuestionIncrementPressed>((_, emit) async {
      final substanceData = await FirestoreProvider().getRandomSubstance();

      final degreeTypeList = _getTwoDifferentNumber();
      final givenDegreeData =
          await FirestoreProvider().getRandomDegree(degreeTypeList[0]);
      final desiredDegreeData =
          await FirestoreProvider().getRandomDegree(degreeTypeList[1]);

      emit(Question(
        givenRate: _getRate(),
        substance: Substance(
          id: substanceData['id'],
          formula: substanceData['formula'],
          amount: substanceData['amount'],
          commonName: substanceData['commonName'],
        ),
        givenDegree: Degree(
          type: givenDegreeData['type'],
          name: givenDegreeData['name'],
          degree: givenDegreeData['degree'],
          baseValue: givenDegreeData['baseValue'],
        ),
        desiredDegree: Degree(
          type: desiredDegreeData['type'],
          name: desiredDegreeData['name'],
          degree: desiredDegreeData['degree'],
          baseValue: desiredDegreeData['baseValue'],
        ),
        answer: 1,
      ));
    });
  }
}

List<int> _getTwoDifferentNumber() {
  while (true) {
    final int num1 = Random().nextInt(4);
    final int num2 = Random().nextInt(4);
    if (num1 != num2) return [num1, num2];
  }
}

double _getRate() {
  final List<double> rateList = [0.01, 0.1, 0.2, 0.5, 1.5, 2, 5, 10];
  return rateList[Random().nextInt(rateList.length)];
}
