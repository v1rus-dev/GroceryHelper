import 'package:dartz/dartz.dart';
import 'package:groceryhelper/shared/errors/errors.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';

class GetProductsListUsecase {
  final ProductsRepository _productsRepository;

  GetProductsListUsecase(this._productsRepository);

  Future<Either<AppError, List<ProductItem>>> call() async {
    return await _productsRepository.getAllProducts();
  }
}
