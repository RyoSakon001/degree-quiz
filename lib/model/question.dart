import 'package:degree_quiz/model/Degree.dart';
import 'package:degree_quiz/model/Substance.dart';

class Question {
  Question({
    required this.givenRate,
    required this.substance,
    required this.degree,
    required this.answer,
  });
  final int givenRate;
  final Substance substance;
  final Degree degree;
  final num answer;
}

extension QuestionExtention on Question {
  String get sentence =>
      '${(degree.baseValue * 2).toStringAsFixed(2) + degree.degree}の${substance.commonName + substance.formula}の${degree.name}を求めよ。';
}
