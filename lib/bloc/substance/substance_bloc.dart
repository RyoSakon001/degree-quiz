import 'package:degree_quiz/bloc/substance/substance_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubstanceBloc extends Bloc<SubstanceEvent, String> {
  SubstanceBloc() : super('') {
    on<SubstanceIncrementPressed>((event, emit) {
      return emit('a$state');
    });
  }
}
