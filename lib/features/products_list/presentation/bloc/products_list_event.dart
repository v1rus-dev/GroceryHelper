part of 'products_list_bloc.dart';

@immutable
sealed class ProductsListEvent {
  const ProductsListEvent();
}

class ProductsListInitial extends ProductsListEvent {}

class UpdateSearchQuery extends ProductsListEvent {
  final String query;

  const UpdateSearchQuery(this.query);
}

class UpdateProductsList extends ProductsListEvent {
  final List<ProductItemWithType>? products;

  const UpdateProductsList({this.products});
}

class UpdateSelectedCategory extends ProductsListEvent {
  final ProductCategory? category;

  const UpdateSelectedCategory({this.category});
}

class DeleteProduct extends ProductsListEvent {
  final ProductItemWithType product;

  const DeleteProduct({required this.product});
}
