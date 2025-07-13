import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';

class AddProductTypeUseCase {
  final ProductTypeRepository repository;

  AddProductTypeUseCase({required this.repository});

  /// Добавляет новый тип продукта
  /// [category] - категория продукта
  /// [name] - название типа
  /// [typeId] - опциональный уникальный ID. Если не указан, будет сгенерирован автоматически
  Future<int> execute(ProductCategory category, String name) async {
    return repository.addProductType(category, name);
  }
}
