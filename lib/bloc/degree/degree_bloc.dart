import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degree_quiz/bloc/Degree/Degree_event.dart';
import 'package:degree_quiz/model/Degree.dart';
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
      final degreeSnapshot =
          await FirebaseFirestore.instance.collection('Degrees').doc('1').get();
      final degreeData = degreeSnapshot.exists ? degreeSnapshot.data() : null;

      if (degreeData != null) {
        emit(
          Degree(
              type: degreeData['type'],
              name: degreeData['name'],
              degree: degreeData['degree'],
              baseValue: degreeData['baseValue']),
        );
      }
    });
  }
}
