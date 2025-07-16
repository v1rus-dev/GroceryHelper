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
  final List<ProductItem>? products;

  const UpdateProductsList({this.products});
}
