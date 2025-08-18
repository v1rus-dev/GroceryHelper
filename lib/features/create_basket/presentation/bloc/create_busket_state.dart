part of 'create_busket_bloc.dart';

class CreateBusketState extends Equatable {
  const CreateBusketState({required this.selectedIcon, required this.selectedColor, required this.tags});

  final DefaultIconSet selectedIcon;
  final Color selectedColor;
  final List<String> tags;

  @override
  List<Object> get props => [selectedIcon, selectedColor, tags];

  CreateBusketState copyWith({DefaultIconSet? selectedIcon, Color? selectedColor, List<String>? tags}) {
    return CreateBusketState(
      selectedIcon: selectedIcon ?? this.selectedIcon,
      selectedColor: selectedColor ?? this.selectedColor,
      tags: tags ?? this.tags,
    );
  }
}
