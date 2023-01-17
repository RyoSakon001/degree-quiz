import 'package:degree_quiz/bloc/degree/degree_event.dart';
import 'package:degree_quiz/firestore_provider.dart';
import 'package:degree_quiz/model/degree.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DegreeBloc extends Bloc<DegreeEvent, Degree> {
  DegreeBloc()
      : super(Degree(
          type: 0,
          name: '',
          degree: '',
          baseValue: 1,
        )) {
    on<DegreeIncrementPressed>((_, emit) async {
      final degreeData = await FirestoreProvider().getRandomDegree();

      emit(Degree(
        type: degreeData['type'],
        name: degreeData['name'],
        degree: degreeData['degree'],
        baseValue: degreeData['baseValue'],
      ));
    });
  }
}
