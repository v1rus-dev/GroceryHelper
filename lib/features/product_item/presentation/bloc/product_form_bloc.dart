import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/units.dart';
import 'package:groceryhelper/domain/repositories/product_types_repository.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductItemBloc extends Bloc<ProductItemEvent, ProductItemState> {
  final ProductTypesRepository productTypesRepository;
  final ProductsRepository productsRepository;

  ProductItemBloc({required this.productTypesRepository, required this.productsRepository})
    : super(ProductItemState(category: ProductCategory.food)) {
    on<ProductItemInit>(_onInit);
    on<ProductItemCategorySelected>(_onCategorySelected);
    on<ProductItemTypeSelected>(_onTypeSelected);
    on<ProductItemSave>(_onSave);
  }

  _onInit(ProductItemInit event, Emitter<ProductItemState> emit) async {
    TalkerService.log('ProductItemBloc init event');
    try {
      final productTypes = await productTypesRepository.getProductTypesByCategory(state.category);
      productTypes.fold(
        (error) {
          TalkerService.error(error.message);
        },
        (types) {
          emit(state.copyWith(type: types.firstOrNull));
        },
      );
    } catch (e) {
      TalkerService.error('Ошибка при инициализации ProductItemBloc: $e');
    }
  }

  _onCategorySelected(ProductItemCategorySelected event, Emitter<ProductItemState> emit) async {
    if (event.category == state.category) return;

    try {
      if (event.updateType) {
        final productTypes = await productTypesRepository.getProductTypesByCategory(event.category);
        productTypes.fold(
          (error) {
            TalkerService.error(error.message);
          },
          (types) {
            emit(state.copyWith(category: event.category, type: types.firstOrNull));
          },
        );
      } else {
        emit(state.copyWith(category: event.category));
      }
    } catch (e) {
      TalkerService.error('Ошибка при смене категории: $e');
      emit(state.copyWith(category: event.category));
    }
  }

  _onTypeSelected(ProductItemTypeSelected event, Emitter<ProductItemState> emit) {
    emit(state.copyWith(type: event.type));
  }

  _onSave(ProductItemSave event, Emitter<ProductItemState> emit) async {
    if (state.type == null) return;
    final result = await productsRepository.addProduct(event.name, state.category, state.type!);
    result.fold(
      (error) {
        TalkerService.error(error.message);
        event.completer.completeError(error);
      },
      (success) {
        TalkerService.log('Продукт успешно добавлен');
        event.completer.complete();
      },
    );
  }
}
