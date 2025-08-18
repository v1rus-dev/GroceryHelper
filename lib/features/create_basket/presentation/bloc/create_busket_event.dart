part of 'create_busket_bloc.dart';

sealed class CreateBusketEvent extends Equatable {
  const CreateBusketEvent();

  @override
  List<Object> get props => [];
}

final class ChangeIconEvent extends CreateBusketEvent {
  const ChangeIconEvent({required this.icon});

  final DefaultIconSet icon;

  @override
  List<Object> get props => [icon];
}

final class ChangeColorEvent extends CreateBusketEvent {
  const ChangeColorEvent({required this.color});

  final Color color;

  @override
  List<Object> get props => [color];
}

final class AddTagEvent extends CreateBusketEvent {
  const AddTagEvent({required this.tag});

  final String tag;

  @override
  List<Object> get props => [tag];
}

final class RemoveTagEvent extends CreateBusketEvent {
  const RemoveTagEvent({required this.tag});

  final String tag;

  @override
  List<Object> get props => [tag];
}
