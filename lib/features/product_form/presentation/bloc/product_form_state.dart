part of 'product_form_bloc.dart';

class ProductFormState extends Equatable {
  ProductFormState({required this.category, required this.type, this.selectedUnit});

  final ProductCategory category;
  final AppProductType type;
  Units? selectedUnit;

  ProductFormState copyWith({ProductCategory? category, AppProductType? type, Units? selectedUnit}) {
    return ProductFormState(
      category: category ?? this.category,
      type: type ?? this.type,
      selectedUnit: selectedUnit ?? this.selectedUnit,
    );
  }

  @override
  List<Object?> get props => [category, type];
}
