import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';
import 'package:meta/meta.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/get_products_list_usecase.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/observe_products_usecase.dart';
import 'package:groceryhelper/features/products_list/domain/usecases/seartch_products_usecase.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  final GetProductsListUsecase getProductsListUsecase;
  final ObserveProductsUsecase observeProductsUsecase;
  final SearchProductsUsecase searchProductsUsecase;
  List<ProductItemWithType> _products = [];

  StreamSubscription<List<ProductItemWithType>>? _productsSubscription;

  ProductsListBloc({
    required this.getProductsListUsecase,
    required this.observeProductsUsecase,
    required this.searchProductsUsecase,
  }) : super(ProductsListState(products: [])) {
    on<ProductsListInitial>(_onProductsListInitial);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
    on<UpdateProductsList>(_onUpdateProductsList);
    on<UpdateSelectedCategory>(_onUpdateSelectedCategory);
    on<DeleteProduct>(_onDeleteProduct);
  }

  _onProductsListInitial(ProductsListInitial event, Emitter<ProductsListState> emit) async {
    final result = await getProductsListUsecase.call();
    result.fold((error) => add(UpdateProductsList(products: [])), (products) {
      _products = products;
      add(UpdateProductsList(products: _products));
    });
    _productsSubscription = observeProductsUsecase.call().listen((products) {
      TalkerService.log('products: ${products.length}');
      _products = products
          .map((product) => ProductItemWithType(productItem: product.productItem, productType: product.productType))
          .toList();
      add(UpdateProductsList(products: products));
    });
  }

  _onUpdateSearchQuery(UpdateSearchQuery event, Emitter<ProductsListState> emit) async {
    final result = await searchProductsUsecase.call(event.query);
    result.fold(
      (error) => add(UpdateProductsList(products: [])),
      (products) => add(UpdateProductsList(products: products)),
    );
  }

  _onUpdateProductsList(UpdateProductsList event, Emitter<ProductsListState> emit) {
    emit(state.copyWith(products: event.products ?? state.products));
  }

  _onUpdateSelectedCategory(UpdateSelectedCategory event, Emitter<ProductsListState> emit) {
    if (event.category == null) {
      emit(state.clearSelectedCategory());
    } else {
      emit(state.copyWith(selectedCategory: event.category));
    }

    final filteredProducts = _filterProducts(_products, event.category);
    TalkerService.log(filteredProducts.toString());
    add(UpdateProductsList(products: filteredProducts));
  }

  List<ProductItemWithType> _filterProducts(List<ProductItemWithType> products, ProductCategory? category) {
    if (category == null) {
      return products;
    }
    return products.where((product) => product.productItem.category == category).toList();
  }

  _onDeleteProduct(DeleteProduct event, Emitter<ProductsListState> emit) {
    _products.removeWhere((product) => product.productItem.id == event.product.productItem.id);
    final filteredProducts = _filterProducts(_products, state.selectedCategory);
    add(UpdateProductsList(products: filteredProducts));
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}
