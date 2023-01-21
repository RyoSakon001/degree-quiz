import 'package:degree_quiz/bloc/sentence/sentence_event.dart';
import 'package:degree_quiz/firestore_provider.dart';
import 'package:degree_quiz/model/Degree.dart';
import 'package:degree_quiz/model/Substance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentenceBloc extends Bloc<SentenceEvent, String> {
  SentenceBloc() : super('') {
    on<SentenceIncrementPressed>((_, emit) async {
      final substanceData = await FirestoreProvider().getRandomSubstance();
      final degreeData = await FirestoreProvider().getRandomDegree();

      final substance = Substance(
        id: substanceData['id'],
        formula: substanceData['formula'],
        amount: substanceData['amount'],
        commonName: substanceData['commonName'],
      );
      final degree = Degree(
        type: degreeData['type'],
        name: degreeData['name'],
        degree: degreeData['degree'],
        baseValue: degreeData['baseValue'],
      );
      final sentence =
          '${(degree.baseValue * 2).toStringAsFixed(2) + degree.degree}の${substance.commonName + substance.formula}の${degree.name}を求めよ。';
      emit(sentence);
    });
  }
}
