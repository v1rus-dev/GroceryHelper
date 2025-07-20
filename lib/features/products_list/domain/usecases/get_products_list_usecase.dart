import 'package:dartz/dartz.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/shared/errors/errors.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

class GetProductsListUsecase {
  final ProductsRepository _productsRepository;

  GetProductsListUsecase(this._productsRepository);

  Future<Either<AppError, List<ProductItemWithType>>> call() async {
    return await _productsRepository.getAllProducts();
  }
}
