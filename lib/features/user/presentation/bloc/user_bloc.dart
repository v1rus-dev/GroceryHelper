import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUsecase authUsecase;

  StreamSubscription? _authStateSubscription;

  UserBloc({required this.authUsecase}) : super(UserInitial()) {
    on<UserInitEvent>(_onInit);
    on<AuthByGoogle>(_onAuthByGoogle);
    on<Unauthorize>(_onUnauthorize);
  }

  _onInit(UserInitEvent event, Emitter<UserState> emit) async {
    await emit.onEach<User?>(
      authUsecase.authStateChanges,
      onData: (user) {
        print('User: $user');
        if (user == null) {
          emit(UserUnauthenticated());
        } else {
          emit(UserAuthenticated());
        }
      },
    );
  }

  _onAuthByGoogle(AuthByGoogle event, Emitter<UserState> emit) async {
    final credentials = await authUsecase.signInWithGoogle();
    credentials.fold(
      (left) {
        TalkerService.error(left.toString());
      },
      (creds) {
        TalkerService.log('User authenticated: ${creds.user?.email}');
      },
    );
  }

  _onUnauthorize(Unauthorize event, Emitter<UserState> emit) async {
    await authUsecase.signOut();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
