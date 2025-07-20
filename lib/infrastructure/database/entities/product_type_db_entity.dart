class ProductTypeDbEntity {
  final int id;
  final String name;
  final int productCategoryId;
  final DateTime createdAt;
  final bool isCustom;
  final int productType;

  ProductTypeDbEntity({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.createdAt,
    required this.isCustom,
    required this.productType,
  });
}
