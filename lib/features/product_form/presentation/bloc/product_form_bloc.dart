import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/units.dart';
import 'package:groceryhelper/features/product_form/domain/repositories/products_repository.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  final ProductsRepository productsRepository;

  ProductFormBloc({required this.productsRepository}) : super(ProductFormState(category: ProductCategory.food)) {
    on<ProductFormInit>(_onInit);
    on<ProductFormCategorySelected>(_onCategorySelected);
    on<ProductFormTypeSelected>(_onTypeSelected);
    on<ProductFormSave>(_onSave);
  }

  _onInit(ProductFormInit event, Emitter<ProductFormState> emit) async {
    final productTypes = await productsRepository.getProductTypes(state.category);
    emit(state.copyWith(type: productTypes.firstOrNull));
  }

  _onCategorySelected(ProductFormCategorySelected event, Emitter<ProductFormState> emit) async {
    if (event.category == state.category) return;

    if (event.updateType) {
      final productTypes = await productsRepository.getProductTypes(event.category);
      emit(state.copyWith(category: event.category, type: productTypes.firstOrNull));
    } else {
      emit(state.copyWith(category: event.category));
    }
  }

  _onTypeSelected(ProductFormTypeSelected event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(type: event.type));
  }

  _onSave(ProductFormSave event, Emitter<ProductFormState> emit) async {
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
