class ProductItemEntity {
  final int id;
  final String name;
  final int productCategoryId;
  final int productTypeId;
  final DateTime createdAt;

  ProductItemEntity({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.productTypeId,
    required this.createdAt,
  });
}
