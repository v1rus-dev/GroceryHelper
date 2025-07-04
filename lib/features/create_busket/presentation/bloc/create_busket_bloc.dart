import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_busket_event.dart';
part 'create_busket_state.dart';

class CreateBusketBloc extends Bloc<CreateBusketEvent, CreateBusketState> {
  CreateBusketBloc() : super(CreateBusketInitial()) {
    on<CreateBusketEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
