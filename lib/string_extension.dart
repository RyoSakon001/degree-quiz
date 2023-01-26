import 'dart:math';
import 'package:degree_quiz/model/question.dart';

extension StringExtension on String {
  String get cutZero {
    String text = this;
    while (text.last == '0') {
      text = text.cutLast;
    }
    if (text.last == '.') {
      text = text.cutLast;
    }
    return text;
  }

  String get last {
    String text = this;
    return text.substring(text.length - 1, text.length);
  }

  String get lastTwo {
    String text = this;
    return text.substring(text.length - 2, text.length);
  }

  String get cutLast {
    String text = this;
    return text.substring(0, text.length - 1);
  }

  String get avogadroDegree {
    String text = this;
    if (!(text.contains('e+') || text.contains('e-'))) return text;

    int power = int.parse(text.lastTwo) + 23;

    text = text.cutLast + power.toString();

    return (text.contains('e+'))
        ? text.replaceFirst('e+', ' ×10^')
        : text.replaceFirst('e-', ' ×10^');
  }

  double rate(Question question) {
    final ansVal = this;
    double val = -1;
    switch (question.desiredDegree.type) {
      case 0:
      case 2:
        val = double.parse(ansVal) / question.desiredDegree.baseValue;
        break;
      case 1:
        val = double.parse(ansVal) / question.substance.amount;
        break;
      case 3:
        if (ansVal.contains(' ×10^')) {
          List<String> list = ansVal.split(' ×10^');
          val = double.parse(list[0]) *
              pow(10, double.parse(list[1]) - 23) /
              question.desiredDegree.baseValue;
        }
        break;
      default:
    }
    val = double.parse(val.toStringAsExponential(2));
    return val;
  }
}
