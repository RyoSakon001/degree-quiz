import 'package:degree_quiz/model/Degree.dart';
import 'package:degree_quiz/model/Substance.dart';

class Question {
  Question({
    required this.givenRate,
    required this.substance,
    required this.givenDegree,
    required this.desiredDegree,
    required this.answer,
  });
  final int givenRate;
  final Substance substance;
  final Degree givenDegree;
  final Degree desiredDegree;
  final num answer;
}

extension QuestionExtention on Question {
  String get sentence =>
      '${(givenDegree.baseValue * 2).toStringAsFixed(2) + givenDegree.degree}の${substance.commonName + substance.formula}の${desiredDegree.name}を求めよ。';
}
