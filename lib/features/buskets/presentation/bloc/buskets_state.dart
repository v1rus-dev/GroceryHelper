part of 'buskets_bloc.dart';

sealed class BusketsState extends Equatable {
  const BusketsState();
  
  @override
  List<Object> get props => [];
}

final class BusketsInitial extends BusketsState {}
