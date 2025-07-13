import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/units.dart';
import 'package:groceryhelper/features/product_form/domain/usecase/create_product_use_case.dart';
import 'package:groceryhelper/features/product_form/domain/usecase/get_product_types_use_case.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  final CreateProductUseCase createProductUseCase;
  final GetProductTypesUseCase getProductTypesUseCase;

  ProductFormBloc({required this.createProductUseCase, required this.getProductTypesUseCase})
    : super(ProductFormState(category: ProductCategory.food)) {
    on<ProductFormInit>(_onInit);
    on<ProductFormCategorySelected>(_onCategorySelected);
    on<ProductFormTypeSelected>(_onTypeSelected);
    on<ProductFormSave>(_onSave);
  }

  _onInit(ProductFormInit event, Emitter<ProductFormState> emit) async {
    TalkerService.log('ProductFormBloc init event');
    try {
      final productTypes = await getProductTypesUseCase.call(state.category);
      TalkerService.log('ProductFormBloc init event: ${productTypes.firstOrNull}');
      emit(state.copyWith(type: productTypes.firstOrNull));
    } catch (e) {
      TalkerService.error('Ошибка при инициализации ProductFormBloc: $e');
      // В случае ошибки оставляем состояние как есть, но логируем ошибку
    }
  }

  _onCategorySelected(ProductFormCategorySelected event, Emitter<ProductFormState> emit) async {
    if (event.category == state.category) return;

    try {
      if (event.updateType) {
        final productTypes = await getProductTypesUseCase.call(event.category);
        emit(state.copyWith(category: event.category, type: productTypes.firstOrNull));
      } else {
        emit(state.copyWith(category: event.category));
      }
    } catch (e) {
      TalkerService.error('Ошибка при смене категории: $e');
      // В случае ошибки просто меняем категорию без обновления типа
      emit(state.copyWith(category: event.category));
    }
  }

  _onTypeSelected(ProductFormTypeSelected event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(type: event.type));
  }

  _onSave(ProductFormSave event, Emitter<ProductFormState> emit) async {
    if (state.type == null) return;
    final result = await createProductUseCase.call(event.name, state.category, state.type!);
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
