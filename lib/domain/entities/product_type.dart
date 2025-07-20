import 'package:equatable/equatable.dart';
import '../enums/product_category.dart';
import '../enums/product_type.dart' as domain_product_type;

class ProductType extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;
  final DateTime createdAt;
  final bool isCustom;

  const ProductType({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.isCustom,
  });

  domain_product_type.ProductType get productType => domain_product_type.ProductTypeHelper.fromId(id);

  ProductType copyWith({int? id, String? name, ProductCategory? category, DateTime? createdAt, bool? isCustom}) {
    return ProductType(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  @override
  List<Object?> get props => [id, name, category, createdAt, isCustom];
}
