import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

class ObserveProductsUsecase {
  final ProductsRepository productsRepository;

  ObserveProductsUsecase(this.productsRepository);

  Stream<List<ProductItemWithType>> call() {
    return productsRepository.observeProducts();
  }
}
