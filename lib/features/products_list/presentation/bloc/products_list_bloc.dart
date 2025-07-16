import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
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

  StreamSubscription<List<ProductItemWithType>>? _productsSubscription;

  ProductsListBloc({
    required this.getProductsListUsecase,
    required this.observeProductsUsecase,
    required this.searchProductsUsecase,
  }) : super(ProductsListState(products: [])) {
    on<ProductsListInitial>(_onProductsListInitial);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
    on<UpdateProductsList>(_onUpdateProductsList);
  }

  _onProductsListInitial(ProductsListInitial event, Emitter<ProductsListState> emit) async {
    TalkerService.log('ProductsListInitial');
    final result = await getProductsListUsecase.call();
    result.fold(
      (error) => add(UpdateProductsList(products: [])),
      (products) => add(UpdateProductsList(products: products)),
    );
    _productsSubscription = observeProductsUsecase.call().listen((products) {
      TalkerService.log(products.toString());
      add(UpdateProductsList(products: products.map((product) => product.productItem).toList()));
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

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}
