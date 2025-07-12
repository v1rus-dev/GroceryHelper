part of 'category_type_bloc.dart';

sealed class CategoryTypeEvent extends Equatable {
  const CategoryTypeEvent();

  @override
  List<Object> get props => [];
}

class CategoryTypeInitialized extends CategoryTypeEvent {
  const CategoryTypeInitialized();

  @override
  List<Object> get props => [];
}

class CategoryTypeSelected extends CategoryTypeEvent {
  const CategoryTypeSelected({required this.category});

  final ProductCategory category;

  @override
  List<Object> get props => [category];
}

class CategoryTypeUpdateTypes extends CategoryTypeEvent {
  @override
  List<Object> get props => [];
}

class CategoryTypeAddCustomType extends CategoryTypeEvent {
  const CategoryTypeAddCustomType({required this.name, required this.category, required this.completer});

  final String name;
  final ProductCategory category;
  final Completer completer;

  @override
  List<Object> get props => [name, category];
}
