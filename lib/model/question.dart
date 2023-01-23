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
  final double givenRate;
  final Substance substance;
  final Degree givenDegree;
  final Degree desiredDegree;
  final num answer;
}

extension QuestionExtention on Question {
  String get sentence {
    String val = '';
    val += _getAmount();
    val += (givenDegree.type == 3) ? ' × 10^23' : '';
    val += givenDegree.degree;
    val += 'の';
    val += substance.commonName;
    val += substance.formula;
    val += 'の';
    val += desiredDegree.name;
    val += 'を求めよ。';
    return val;
  }

  String _getAmount() {
    num baseValue = (givenDegree.type == 1) // 1:質量
        ? substance.amount
        : givenDegree.baseValue;
    baseValue *= givenRate;
    switch (givenDegree.type) {
      case 0: // mol
        // TODO: 処理
        break;
      case 1: // g
        // TODO: 処理
        break;
      case 2: // L
        // TODO: 処理
        break;
      case 3: // 個
        // TODO: 処理
        break;
      default:
    }

    return baseValue.toStringAsFixed(2);
  }
}
