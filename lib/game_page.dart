import 'package:degree_quiz/app_text_style.dart';
import 'package:degree_quiz/bloc/degree/degree_bloc.dart';
import 'package:degree_quiz/bloc/question/question_bloc.dart';
import 'package:degree_quiz/bloc/question/question_event.dart';
import 'package:degree_quiz/bloc/substance/substance_bloc.dart';
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
        BlocProvider(create: (_) => SubstanceBloc()),
        BlocProvider(create: (_) => DegreeBloc()),
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
    final answerDegree = useState('');
    final answerType = useState(-1);
    final bool isiPad = MediaQuery.of(context).size.width >= 560;

    return Scaffold(
      body: BlocBuilder<QuestionBloc, Question>(
        builder: (context, question) => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isiPad ? 64 : 16,
              horizontal: isiPad ? 200 : 24,
            ),
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
                      child: Text('条件'),
                    ),
                  ],
                ),
                Text(
                  isResult.value
                      ? '終了！\n最終スコア：${scoreState.value}'
                      : '${questionNumberState.value}問目\n得点：${scoreState.value}/100',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: isiPad ? 24 : 12),
                ),
                SizedBox(height: 32),
                questionNumberState.value == 11
                    ? Text('')
                    : Text(
                        question.sentence,
                        style: appTextStyle(isiPad: isiPad),
                      ),
                SizedBox(
                  height: isiPad ? 36 : 18,
                  child: Text(validator.value,
                      style: TextStyle(
                        fontSize: isiPad ? 28 : 12,
                        color: Colors.red,
                      )),
                ),
                isResult.value
                    ? SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            isResult.value = false;
                            questionNumberState.value = 1;
                            scoreState.value = 0;
                          },
                          child: Text('再チャレンジ'),
                        ),
                      )
                    : Text(
                        answerNumber.value + answerDegree.value,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500),
                      ),
                SizedBox(height: 32),
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
                          switch (entry.key) {
                            case 16: // clear
                              answerNumber.value = '';
                              answerDegree.value = '';
                              break;
                            case 17: // Enter
                              if (answerNumber.value.isEmpty) {
                                validator.value = '数値を入力してください。';
                                return;
                              }
                              if (answerDegree.value.isEmpty) {
                                validator.value = '単位を入力してください。';
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
                              if (answerType.value ==
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
                              answerDegree.value = '';
                              validator.value = '';
                              // 次の問題を出す
                              context
                                  .read<QuestionBloc>()
                                  .add(QuestionChanged());

                              break;
                            case 12: // mol
                            case 13: // g
                            case 14: // L
                            case 15: // 個
                              answerDegree.value = entry.value;
                              answerType.value = entry.key - 12; // 0,1,2,3
                              break;
                            default:
                              // 答えが長すぎたらそれ以上入力できない
                              if (answerNumber.value.length >= 10) {
                                validator.value = '数値は10文字以内で入力してください。';
                                return;
                              }
                              answerNumber.value += entry.value;
                              break;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          primary: (entry.key <= 11)
                              ? Colors.blue
                              : (entry.key <= 15)
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
}
