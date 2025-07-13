import 'package:equatable/equatable.dart';
import '../enums/product_category.dart';
import '../enums/product_type.dart' as domain_product_type;

class ProductType extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;
  final DateTime createdAt;
  final bool isCustom;
  final domain_product_type.ProductType? productType;

  const ProductType({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.isCustom,
    this.productType,
  });

  ProductType copyWith({
    int? id,
    String? name,
    ProductCategory? category,
    DateTime? createdAt,
    bool? isCustom,
    domain_product_type.ProductType? productType,
  }) {
    return ProductType(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isCustom: isCustom ?? this.isCustom,
      productType: productType ?? this.productType,
    );
  }

  @override
  List<Object?> get props => [id, name, category, createdAt, isCustom, productType];
}
