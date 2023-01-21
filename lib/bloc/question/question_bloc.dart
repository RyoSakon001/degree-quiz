import 'package:degree_quiz/bloc/question/question_event.dart';
import 'package:degree_quiz/firestore_provider.dart';
import 'package:degree_quiz/model/Degree.dart';
import 'package:degree_quiz/model/Substance.dart';
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
            degree: Degree(
              type: 0,
              name: '',
              degree: '',
              baseValue: 1,
            ),
            answer: 1)) {
    on<QuestionIncrementPressed>((_, emit) async {
      final substanceData = await FirestoreProvider().getRandomSubstance();
      final degreeData = await FirestoreProvider().getRandomDegree();

      emit(Question(
        givenRate: 1,
        substance: Substance(
          id: substanceData['id'],
          formula: substanceData['formula'],
          amount: substanceData['amount'],
          commonName: substanceData['commonName'],
        ),
        degree: Degree(
          type: degreeData['type'],
          name: degreeData['name'],
          degree: degreeData['degree'],
          baseValue: degreeData['baseValue'],
        ),
        answer: 1,
      ));
    });
  }
}
