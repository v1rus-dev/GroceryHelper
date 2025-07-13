import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

class GetProductTypesUseCase {
  final ProductsRepository productsRepository;

  GetProductTypesUseCase({required this.productsRepository});

  Future<List<ProductType>> call(ProductCategory category) async {
    return productsRepository.getProductTypes(category);
  }
}
