part of 'category_type_bloc.dart';

final class CategoryTypeState extends Equatable {
  const CategoryTypeState({required this.category, required this.types});

  final ProductCategory category;
  final List<ProductType> types;

  CategoryTypeState copyWith({ProductCategory? category, List<ProductType>? types}) {
    return CategoryTypeState(category: category ?? this.category, types: types ?? this.types);
  }

  @override
  List<Object?> get props => [category, types];
}
