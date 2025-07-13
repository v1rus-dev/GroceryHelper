import 'package:equatable/equatable.dart';
import '../enums/product_category.dart';

class ProductItem extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;
  final int productTypeId;
  final DateTime createdAt;
  final String? itemId;
  final List<String> tags;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.productTypeId,
    required this.createdAt,
    this.itemId,
    this.tags = const [],
  });

  ProductItem copyWith({
    int? id,
    String? name,
    ProductCategory? category,
    int? productTypeId,
    DateTime? createdAt,
    String? itemId,
    List<String>? tags,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      productTypeId: productTypeId ?? this.productTypeId,
      createdAt: createdAt ?? this.createdAt,
      itemId: itemId ?? this.itemId,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [id, name, category, productTypeId, createdAt, itemId, tags];
}
