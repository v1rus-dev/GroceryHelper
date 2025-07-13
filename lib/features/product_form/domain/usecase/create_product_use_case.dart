import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

class CreateProductUseCase {
  final ProductsRepository productsRepository;

  CreateProductUseCase({required this.productsRepository});

  Future<Either<AppError, void>> call(String name, ProductCategory category, ProductType productType) async {
    return productsRepository.addProduct(name, category, productType);
  }
}
