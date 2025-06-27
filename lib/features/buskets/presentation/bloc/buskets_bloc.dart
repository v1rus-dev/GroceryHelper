import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'buskets_event.dart';
part 'buskets_state.dart';

class BusketsBloc extends Bloc<BusketsEvent, BusketsState> {
  BusketsBloc() : super(BusketsInitial()) {
    on<BusketsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
