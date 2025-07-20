import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import '../enums/product_category.dart';

class ProductItem extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;
  final int productTypeId;
  final String? customProductType;
  final DateTime createdAt;
  final List<String> tags;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.productTypeId,
    this.customProductType,
    required this.createdAt,
    this.tags = const [],
  });

  ProductType get productType => ProductTypeHelper.fromId(productTypeId);

  ProductItem copyWith({
    int? id,
    String? name,
    ProductCategory? category,
    int? productTypeId,
    String? customProductType,
    DateTime? createdAt,
    String? itemId,
    List<String>? tags,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      productTypeId: productTypeId ?? this.productTypeId,
      customProductType: customProductType ?? this.customProductType,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [id, name, category, productTypeId, createdAt, tags];
}
