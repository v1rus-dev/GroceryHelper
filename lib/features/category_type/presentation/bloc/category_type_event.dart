part of 'category_type_bloc.dart';

sealed class CategoryTypeEvent extends Equatable {
  const CategoryTypeEvent();

  @override
  List<Object> get props => [];
}

class CategoryTypeSelected extends CategoryTypeEvent {
  const CategoryTypeSelected({required this.category});

  final ProductCategory category;
}
