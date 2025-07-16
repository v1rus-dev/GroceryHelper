import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';

class ProductItemWithType extends Equatable {
  final ProductItem productItem;
  final ProductType productType;

  const ProductItemWithType({required this.productItem, required this.productType});

  @override
  List<Object?> get props => [productItem, productType];
}
