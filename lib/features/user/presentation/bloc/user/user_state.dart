part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserAuthenticated extends UserState {
  final String name;

  const UserAuthenticated({required this.name});

  @override
  List<Object> get props => [name];
}
