class ProductItemDbEntity {
  final int id;
  final String name;
  final int productCategoryId;
  final int productTypeId;
  final DateTime createdAt;

  ProductItemDbEntity({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.productTypeId,
    required this.createdAt,
  });
}
