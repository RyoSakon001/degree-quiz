import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:degree_quiz/model/Substance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubstanceBloc extends Bloc<SubstanceEvent, Substance> {
  SubstanceBloc()
      : super(Substance(
          id: 0,
          formula: '',
          amount: 1,
          commonName: '',
        )) {
    on<SubstanceIncrementPressed>((_, emit) async {
      final substanceSnapshot = await FirebaseFirestore.instance
          .collection('substances')
          .doc('CO[2]')
          .get();
      final substanceData =
          substanceSnapshot.exists ? substanceSnapshot.data() : null;

      if (substanceData != null) {
        emit(Substance(
          id: substanceData['id'],
          formula: substanceData['formula'],
          amount: substanceData['amount'],
          commonName: substanceData['name_common'],
        ));
      }
    });
  }
}
