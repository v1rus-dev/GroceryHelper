import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import 'package:groceryhelper/domain/enums/units.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc()
    : super(
        ProductFormState(
          category: ProductCategory.food,
          type: AppProductTypeDefault(type: ProductType.freshProduce),
        ),
      ) {
    on<ProductFormCategorySelected>(_onCategorySelected);
    on<ProductFormTypeSelected>(_onTypeSelected);
  }

  _onCategorySelected(ProductFormCategorySelected event, Emitter<ProductFormState> emit) {
    if (event.category == state.category) return;

    emit(
      state.copyWith(
        category: event.category,
        type: AppProductTypeDefault(type: ProductTypeUtils.getTypesForCategory(event.category).first),
      ),
    );
  }

  _onTypeSelected(ProductFormTypeSelected event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(type: event.type));
  }
}
