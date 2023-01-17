import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:degree_quiz/firestore_provider.dart';
import 'package:degree_quiz/model/substance.dart';
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
      final substanceData = await FirestoreProvider().getRandomSubstance();

      emit(Substance(
        id: substanceData['id'],
        formula: substanceData['formula'],
        amount: substanceData['amount'],
        commonName: substanceData['name_common'],
      ));
    });
  }
}
