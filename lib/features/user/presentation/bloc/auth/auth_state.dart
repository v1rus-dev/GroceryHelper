part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final bool isDialogState;

  const AuthState({this.isDialogState = false});

  @override
  List<Object> get props => [];
}

sealed class AuthDialogState extends AuthState {
  const AuthDialogState({super.isDialogState = true});
}

final class AuthLoading extends AuthDialogState {}

final class AuthFailure extends AuthDialogState {
  final AppError error;

  const AuthFailure({required this.error});
}

final class AuthSuccess extends AuthDialogState {}

sealed class AuthContentState extends AuthState {
  const AuthContentState({super.isDialogState = false});
}

final class AuthInitial extends AuthContentState {}

final class Authenticated extends AuthContentState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends AuthContentState {}
