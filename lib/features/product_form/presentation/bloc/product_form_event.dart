part of 'product_form_bloc.dart';

sealed class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object> get props => [];
}

class ProductFormInit extends ProductFormEvent {
  const ProductFormInit();
}

class ProductFormCategorySelected extends ProductFormEvent {
  const ProductFormCategorySelected({required this.category, required this.updateType});

  final ProductCategory category;
  final bool updateType;
}

class ProductFormTypeSelected extends ProductFormEvent {
  const ProductFormTypeSelected({required this.type});

  final ProductType type;
}

class ProductFormSave extends ProductFormEvent {
  const ProductFormSave({required this.name, required this.completer});

  final String name;
  final Completer completer;
}
