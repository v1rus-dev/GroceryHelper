import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInitEvent>(_onInit);
  }

  _onInit(UserInitEvent event, Emitter<UserState> emit) async {}

  @override
  Future<void> close() {
    return super.close();
  }
}
