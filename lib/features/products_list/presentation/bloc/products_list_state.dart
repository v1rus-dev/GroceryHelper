part of 'products_list_bloc.dart';

@immutable
final class ProductsListState extends Equatable {
  final List<ProductItemWithType> products;
  final ProductCategory? selectedCategory;

  const ProductsListState({required this.products, this.selectedCategory});

  ProductsListState copyWith({List<ProductItemWithType>? products, ProductCategory? selectedCategory}) {
    return ProductsListState(
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  ProductsListState clearSelectedCategory() {
    return ProductsListState(products: products, selectedCategory: null);
  }

  @override
  List<Object?> get props => [products, selectedCategory];
}
