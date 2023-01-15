import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubstanceBloc extends Bloc<SubstanceEvent, int> {
  SubstanceBloc() : super(0) {
    on<SubstanceIncrementPressed>((event, emit) => emit(state + 1));
  }
}
