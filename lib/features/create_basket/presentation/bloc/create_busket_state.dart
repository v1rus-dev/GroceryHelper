part of 'create_busket_bloc.dart';

sealed class CreateBusketState extends Equatable {
  const CreateBusketState();
  
  @override
  List<Object> get props => [];
}

final class CreateBusketInitial extends CreateBusketState {}
