class ProductTypeEntity {
  final int id;
  final String name;
  final int productCategoryId;
  final DateTime createdAt;
  final bool isCustom;
  final int productType;

  ProductTypeEntity({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.createdAt,
    required this.isCustom,
    required this.productType,
  });
}
