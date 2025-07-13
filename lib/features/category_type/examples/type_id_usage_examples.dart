import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/features/category_type/domain/usecases/add_product_type_usecase.dart';

/// Примеры использования автоматической генерации typeId
class TypeIdUsageExamples {
  final AddProductTypeUseCase addProductTypeUseCase;

  TypeIdUsageExamples({required this.addProductTypeUseCase});

  /// Пример 1: Автоматическая генерация typeId
  Future<void> exampleAutoGenerateTypeId() async {
    // typeId будет сгенерирован автоматически
    final id = await addProductTypeUseCase.execute(ProductCategory.food, 'Молоко');
    print('Добавлен тип с автоматически сгенерированным typeId: $id');
  }

  /// Пример 2: Указание конкретного typeId
  Future<void> exampleCustomTypeId() async {
    // Указываем конкретный typeId
    final id = await addProductTypeUseCase.execute(ProductCategory.home, 'Моющее средство');
    print('Добавлен тип с указанным typeId: $id');
  }

  /// Пример 3: Использование в BLoC
  Future<void> exampleInBloc() async {
    // В BLoC можно использовать так:
    // bloc.add(CategoryTypeAddCustomType(
    //   name: 'Новый тип',
    //   category: ProductCategory.food,
    //   completer: completer,
    //   typeId: 99999, // опционально
    // ));
  }

  /// Пример 4: Генерация уникального typeId для синхронизации
  Future<void> exampleForSync() async {
    // Для синхронизации с внешними системами
    final syncId = DateTime.now().millisecondsSinceEpoch;
    final id = await addProductTypeUseCase.execute(ProductCategory.personal, 'Средство для лица');
    print('Добавлен тип с sync ID: $id');
  }
}
