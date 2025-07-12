part of 'product_form_bloc.dart';

class ProductFormState extends Equatable {
  const ProductFormState({required this.category, required this.type});

  final ProductCategory category;
  final AppProductType type;

  ProductFormState copyWith({ProductCategory? category, AppProductType? type}) {
    return ProductFormState(category: category ?? this.category, type: type ?? this.type);
  }

  @override
  List<Object?> get props => [category, type];
}
