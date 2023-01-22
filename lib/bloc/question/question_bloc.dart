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
      // final degreeNumList = useState([0, 0]);
      // while (degreeNumList.value[0] == degreeNumList.value[1]) {
      //   degreeNumList.value[0] == Random().nextInt(4);
      //   degreeNumList.value[1] == Random().nextInt(4);
      // }
      final givenDegreeData = await FirestoreProvider().getRandomDegree(0);
      final desiredDegreeData = await FirestoreProvider().getRandomDegree(1);

      emit(Question(
        givenRate: 1,
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
