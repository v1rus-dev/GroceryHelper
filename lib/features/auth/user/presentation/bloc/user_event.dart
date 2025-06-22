part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class UserInitEvent extends UserEvent {}

final class AuthByGoogle extends UserEvent {}
