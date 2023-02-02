import 'package:degree_quiz/app_text_style.dart';
import 'package:degree_quiz/bloc/question/question_bloc.dart';
import 'package:degree_quiz/bloc/question/question_event.dart';
import 'package:degree_quiz/constants.dart';
import 'package:degree_quiz/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:degree_quiz/string_extension.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QuestionBloc()),
      ],
      child: const GameView(),
    );
  }
}

class GameView extends HookWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<QuestionBloc>().add(QuestionChanged());
      return;
    }, []);

    final questionNumberState = useState(1);
    final scoreState = useState(0);
    final isResult = useState(false);
    final isCorrect = useState(false);
    final validator = useState('');
    final answerNumber = useState('');
    final answerDegreeType = useState(-1);
    final bool isiPad = MediaQuery.of(context).size.width >= 560;

    return Scaffold(
      body: BlocBuilder<QuestionBloc, Question>(
        builder: (context, question) => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isiPad ? 64 : 16,
              horizontal: isiPad ? 180 : 24,
            ),
            child: Column(
              children: [
                // 上の部分
                SizedBox(
                  height: isiPad ? 96 : 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          '戻る',
                          style: appTextStyle(
                            isiPad: isiPad,
                          ),
                        ),
                      ),
                      if (questionNumberState.value != 1)
                        Text(
                          isCorrect.value ? '正解！' : '残念！',
                          style: appTextStyle(
                            isiPad: isiPad,
                            color: isCorrect.value ? Colors.red : Colors.blue,
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () => _showCondition(context),
                        child: Text(
                          '条件',
                          style: appTextStyle(
                            isiPad: isiPad,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 中段
                Text(
                  isResult.value
                      ? '終了！\n最終スコア：${scoreState.value}'
                      : '${questionNumberState.value}問目\n得点：${scoreState.value}/100',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: isiPad ? 24 : 12),
                ),
                SizedBox(height: 32),
                // 問題文
                SizedBox(
                  height: isiPad ? 108 : 54,
                  child: isResult.value
                      ? ElevatedButton(
                          onPressed: () {
                            isResult.value = false;
                            questionNumberState.value = 1;
                            scoreState.value = 0;
                          },
                          child: Text(
                            '再チャレンジ',
                            style: appTextStyle(isiPad: isiPad),
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                              children: question.sentenceSpans(isiPad)),
                        ),
                ),
                // バリデーションメッセージ
                SizedBox(
                  height: isiPad ? 36 : 18,
                  child: Text(validator.value,
                      style: TextStyle(
                        fontSize: isiPad ? 28 : 12,
                        color: Colors.red,
                      )),
                ),
                // 回答
                Text(
                  answerNumber.value + _getDegreeName(answerDegreeType.value),
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 32),
                // ボタン部分
                Expanded(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: buttonList.asMap().entries.map((entry) {
                      return ElevatedButton(
                        onPressed: () {
                          // 数字ボタン
                          if (_isNumberKey(entry.key)) {
                            if (answerNumber.value.length >= 10) {
                              validator.value = '数値は10文字以内で入力してください。';
                              return;
                            }
                            answerNumber.value += entry.value;
                          }
                          // 単位ボタン
                          if (_isDegreeKey(entry.key)) {
                            answerDegreeType.value = entry.key - 12;
                          }
                          // Clearボタン
                          if (_isClearKey(entry.key)) {
                            answerNumber.value = '';
                            answerDegreeType.value = -1;
                          }
                          // Enterボタン
                          if (_isEnterKey(entry.key)) {
                            validator.value = _validator(
                              numberStr: answerNumber.value,
                              degreeType: answerDegreeType.value,
                            );
                            if (validator.value.isNotEmpty) {
                              return;
                            }

                            // 出題数集計
                            if (questionNumberState.value > 10) {
                              return;
                            } else if (questionNumberState.value == 10) {
                              questionNumberState.value++;
                              isResult.value = true;
                            } else {
                              questionNumberState.value++;
                            }

                            // 答え合わせ
                            // 1.単位 2.数値
                            if (answerDegreeType.value ==
                                    question.desiredDegree.type &&
                                answerNumber.value.rate(question) ==
                                    question.givenRate) {
                              isCorrect.value = true;
                              scoreState.value += 10;
                            } else {
                              isCorrect.value = false;
                            }
                            // テキストクリア
                            answerNumber.value = '';
                            answerDegreeType.value = -1;
                            validator.value = '';
                            // 次の問題を出す
                            context.read<QuestionBloc>().add(QuestionChanged());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          primary: _isNumberKey(entry.key)
                              ? Colors.blue
                              : _isDegreeKey(entry.key)
                                  ? Colors.green
                                  : Colors.amber,
                        ),
                        child: Text(
                          entry.value,
                          style: appTextStyle(isiPad: isiPad),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCondition(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('＜条件＞'),
          content: Text(conditionText),
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

  bool _isNumberKey(int key) {
    return (0 <= key && key <= 11);
  }

  bool _isDegreeKey(int key) {
    return (12 <= key && key <= 15);
  }

  bool _isClearKey(int key) {
    return (key == 16);
  }

  bool _isEnterKey(int key) {
    return (key == 17);
  }

  String _getDegreeName(int type) {
    if (type == 0) {
      return 'mol';
    } else if (type == 1) {
      return 'g';
    } else if (type == 2) {
      return 'L';
    } else if (type == 3) {
      return '個';
    } else {
      return '';
    }
  }

  String _validator({
    required String numberStr,
    required int degreeType,
  }) {
    if (numberStr.isEmpty) {
      return '数値を入力してください。';
    }
    if (degreeType == -1) {
      return '単位を入力してください。';
    }

    // 数値文字列の最初は必ず数値である
    if (!RegExp(r'(\d+)').hasMatch(numberStr[0])) {
      return '数値を正しく入力してください。1';
    }

    // 「.」は２回以上使用できない
    if (RegExp(r"\.").allMatches(numberStr).length >= 2) {
      return '「.」は２回以上使用できません。';
    }

    // 指数は２回以上使用できない
    if (RegExp(r"×").allMatches(numberStr).length >= 2) {
      return '指数は２回以上使用できません。';
    }

    int dotIndex = RegExp(r"\.").firstMatch(numberStr)?.start ?? -1;
    int crossIndex = RegExp(r"\×").firstMatch(numberStr)?.start ?? -1;

    // 「.」を含む場合、前後に必ず数字がある
    if (dotIndex > -1 && !RegExp(r'(\d+)\.(\d+)').hasMatch(numberStr)) {
      return '数値を正しく入力してください。２';
    }

    // 「.」は「×」の後ろにきてはいけない
    if (dotIndex > -1 && crossIndex > -1 && dotIndex > crossIndex) {
      return '指数は正の整数を指定してください。';
    }

    // 指数は必ず数値が必要
    if (crossIndex > -1 && !RegExp(r'\^(\d+)').hasMatch(numberStr)) {
      return '指数を指定してください。';
    }

    return '';
  }
}
