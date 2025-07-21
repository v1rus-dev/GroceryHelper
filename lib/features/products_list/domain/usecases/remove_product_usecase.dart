import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';

class RemoveProductUsecase {
  final ProductsRepository productsRepository;

  RemoveProductUsecase(this.productsRepository);

  Future<Either<AppError, void>> call(int productId) async {
    return await productsRepository.removeProduct(productId);
  }
}
