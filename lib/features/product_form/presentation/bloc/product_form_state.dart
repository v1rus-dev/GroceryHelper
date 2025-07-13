part of 'product_form_bloc.dart';

class ProductFormState extends Equatable {
  ProductFormState({required this.category, this.type, this.selectedUnit});

  final ProductCategory category;
  final ProductType? type;
  final Units? selectedUnit;

  ProductFormState copyWith({ProductCategory? category, ProductType? type, Units? selectedUnit}) {
    return ProductFormState(
      category: category ?? this.category,
      type: type ?? this.type,
      selectedUnit: selectedUnit ?? this.selectedUnit,
    );
  }

  @override
  List<Object?> get props => [category, type, selectedUnit];
}
