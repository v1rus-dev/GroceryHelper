part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthInitEvent extends AuthEvent {}

final class AuthByGoogle extends AuthEvent {}

final class AuthByApple extends AuthEvent {}

final class Unauthorize extends AuthEvent {}

final class ResetToContentState extends AuthEvent {}
