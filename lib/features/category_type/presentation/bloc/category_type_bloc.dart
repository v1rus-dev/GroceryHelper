import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

part 'category_type_event.dart';
part 'category_type_state.dart';

class CategoryTypeBloc extends Bloc<CategoryTypeEvent, CategoryTypeState> {
  final ProductTypeRepository productTypeRepository;

  StreamSubscription<List<AppProductTypeUser>>? _userTypesSubscription;
  List<AppProductTypeUser> _userTypes = [];

  CategoryTypeBloc(ProductCategory category, this.productTypeRepository)
    : super(
        CategoryTypeState(
          category: category,
          types: ProductTypeUtils.getTypesForCategory(
            category,
          ).map((type) => AppProductTypeDefault(type: type)).toList(),
        ),
      ) {
    on<CategoryTypeSelected>(_onCategorySelected);
    on<CategoryTypeInitialized>(_onCategoryTypeInitialized);
    on<CategoryTypeAddCustomType>(_onCategoryTypeAddCustomType);
    on<CategoryTypeUpdateTypes>(_onCategoryTypeUpdateTypes);
  }

  _onCategoryTypeInitialized(CategoryTypeInitialized event, Emitter<CategoryTypeState> emit) {
    _userTypesSubscription = productTypeRepository.watchProductTypes().listen((userTypes) {
      _userTypes.clear();
      _userTypes.addAll(userTypes);
      TalkerService.log('userTypes: $_userTypes');
      add(CategoryTypeUpdateTypes());
    });
  }

  _onCategorySelected(CategoryTypeSelected event, Emitter<CategoryTypeState> emit) {
    emit(state.copyWith(category: event.category, types: getTypes()));
  }

  _onCategoryTypeAddCustomType(CategoryTypeAddCustomType event, Emitter<CategoryTypeState> emit) {
    productTypeRepository.addProductType(event.category, event.name).then((value) {
      event.completer.complete(value);
    });
  }

  _onCategoryTypeUpdateTypes(CategoryTypeUpdateTypes event, Emitter<CategoryTypeState> emit) {
    emit(state.copyWith(types: getTypes()));
  }

  List<AppProductType> getTypes() {
    final defaultTypes = ProductTypeUtils.getTypesForCategory(
      state.category,
    ).map((type) => AppProductTypeDefault(type: type));
    return [...defaultTypes, ..._userTypes.where((type) => type.category == state.category)];
  }

  @override
  Future<void> close() {
    TalkerService.log('CategoryTypeBloc closed');
    _userTypesSubscription?.cancel();
    return super.close();
  }
}
