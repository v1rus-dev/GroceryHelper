part of 'product_form_bloc.dart';

sealed class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object> get props => [];
}

class ProductFormCategorySelected extends ProductFormEvent {
  const ProductFormCategorySelected({required this.category});

  final ProductCategory category;
}

class ProductFormTypeSelected extends ProductFormEvent {
  const ProductFormTypeSelected({required this.type});

  final AppProductType type;
}
