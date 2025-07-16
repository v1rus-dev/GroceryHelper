import 'package:dartz/dartz.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';
import 'package:groceryhelper/shared/errors/errors.dart';

class SearchProductsUsecase {
  final ProductsRepository productsRepository;

  SearchProductsUsecase(this.productsRepository);

  Future<Either<AppError, List<ProductItem>>> call(String query) async {
    return await productsRepository.searchProducts(query);
  }
}
