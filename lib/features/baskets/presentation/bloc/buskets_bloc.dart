part of '../../baskets.dart';

class BusketsBloc extends Bloc<BusketsEvent, BusketsState> {
  BusketsBloc() : super(BusketsInitial()) {
    on<BusketsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
