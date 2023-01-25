import 'package:degree_quiz/model/degree.dart';
import 'package:degree_quiz/model/substance.dart';
import 'package:degree_quiz/string_extension.dart';

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
  final String answer;
}

extension QuestionExtention on Question {
  String get sentence {
    String val = '';

    val += _getAmountStr();
    val += givenDegree.degree;
    val += 'の';
    val += substance.commonName;
    val += substance.formula;
    val += 'の';
    val += desiredDegree.name;
    val += 'を求めよ。';
    return val;
  }

  String _getAmountStr() {
    num amount = (givenDegree.type == 1) // g
        ? substance.amount
        : givenDegree.baseValue;
    amount *= givenRate;

    String val = '';
    switch (givenDegree.type) {
      case 0: // mol
        if (amount >= 10) val = amount.round().toString();
        val = amount.toString();
        break;
      case 1: // g
        // FIXME: モル質量が小数を含むパターンに対応できていないので直す
        if (amount >= 10) {
          val = amount.round().toString();
        } else {
          val = amount.toString();
        }
        break;
      case 2: // L
        val = amount.toStringAsFixed(6).cutZero;
        break;
      case 3: // 個
        val = amount.toStringAsExponential(1).avogadroDegree;
        break;
      default:
    }

    return val;
  }
}
