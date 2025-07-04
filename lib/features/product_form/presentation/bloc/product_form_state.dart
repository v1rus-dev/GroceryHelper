part of 'product_form_bloc.dart';

class ProductFormState extends Equatable {
  const ProductFormState({required this.category, required this.type});

  final ProductCategory category;
  final ProductType type;

  ProductFormState copyWith({ProductCategory? category, ProductType? type}) {
    return ProductFormState(category: category ?? this.category, type: type ?? this.type);
  }

  @override
  List<Object?> get props => [category, type];
}
