import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/core/domain/enums/product_category.dart';
import 'package:groceryhelper/core/domain/enums/product_type.dart';

part 'category_type_event.dart';
part 'category_type_state.dart';

class CategoryTypeBloc extends Bloc<CategoryTypeEvent, CategoryTypeState> {
  CategoryTypeBloc(ProductCategory category)
    : super(CategoryTypeState(category: category, types: ProductTypeUtils.getTypesForCategory(category))) {
    on<CategoryTypeSelected>(_onCategorySelected);
  }

  _onCategorySelected(CategoryTypeSelected event, Emitter<CategoryTypeState> emit) {
    emit(state.copyWith(category: event.category, types: ProductTypeUtils.getTypesForCategory(event.category)));
  }
}
