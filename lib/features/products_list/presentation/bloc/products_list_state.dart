part of 'products_list_bloc.dart';

@immutable
final class ProductsListState extends Equatable {
  final List<ProductItem> products;

  const ProductsListState({required this.products});

  ProductsListState copyWith({List<ProductItem>? products}) {
    return ProductsListState(products: products ?? this.products);
  }

  @override
  List<Object?> get props => [products];
}
