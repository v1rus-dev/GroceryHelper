part of 'product_form_bloc.dart';

sealed class ProductItemEvent extends Equatable {
  const ProductItemEvent();

  @override
  List<Object> get props => [];
}

class ProductItemInit extends ProductItemEvent {
  const ProductItemInit();
}

class ProductItemCategorySelected extends ProductItemEvent {
  const ProductItemCategorySelected({required this.category, required this.updateType});

  final ProductCategory category;
  final bool updateType;
}

class ProductItemTypeSelected extends ProductItemEvent {
  const ProductItemTypeSelected({required this.type});

  final ProductType type;
}

class ProductItemSave extends ProductItemEvent {
  const ProductItemSave({required this.name, required this.completer});

  final String name;
  final Completer completer;
}
