import 'package:flutter/material.dart';
import 'package:degree_quiz/app_text_style.dart';
import 'package:degree_quiz/model/degree.dart';
import 'package:degree_quiz/model/substance.dart';
import 'package:degree_quiz/string_extension.dart';

class Question {
  Question({
    required this.givenRate,
    required this.substance,
    required this.givenDegree,
    required this.desiredDegree,
  });
  final double givenRate;
  final Substance substance;
  final Degree givenDegree;
  final Degree desiredDegree;
}

extension QuestionExtention on Question {
  List<TextSpan> sentenceSpans(bool isiPad) {
    return <TextSpan>[
      TextSpan(
        text: '${_getAmountStr()}${givenDegree.degree}の${substance.commonName}',
        style: appTextStyle(
          isiPad: isiPad,
          color: Colors.black,
        ),
      ),
      ...formulaTextSpans,
      TextSpan(
        text: 'の${desiredDegree.name}を求めよ。',
        style: appTextStyle(
          isiPad: isiPad,
          color: Colors.black,
        ),
      ),
    ];
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

  List<TextSpan> get formulaTextSpans {
    String formula = substance.formula;
    // アルファベットと数値以外を削除
    formula.replaceAll(RegExp(r'[^A-Za-z\d]'), '');

    List<String> textList = [];
    String tmp = "";

    // 文字列のかたまりと数字に分割し、List化する
    bool isDigit = formula[0].contains(RegExp(r'\d'));
    for (int i = 0; i < formula.length; i++) {
      if (formula[i].contains(RegExp(r'\d')) != isDigit) {
        textList.add(tmp);
        tmp = "";
        isDigit = !isDigit;
      }
      tmp += formula[i];
    }
    textList.add(tmp);

    // 数字だったら小さい文字にする
    List<TextSpan> textSpans = [];
    for (String item in textList) {
      textSpans.add(TextSpan(
          text: item,
          style: TextStyle(
            fontSize: item.contains(RegExp(r'\d')) ? 14 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )));
    }
    return textSpans;
  }
}
