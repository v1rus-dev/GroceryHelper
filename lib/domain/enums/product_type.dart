import 'product_category.dart';

enum ProductType {
  // Food
  freshProduce,
  drinks,
  snacks,
  dairy,
  canned,
  bakery,

  // Home
  cleaning,
  paperProducts,
  airFresheners,
  kitchenSupplies,

  // Personal
  hygiene,
  skincare,
  medicine,
  cosmetics,

  // Pets
  petFood,
  petCare,
  petToys,

  // Baby
  diapers,
  babyFood,
  babyCare,
  babyToys,

  // Generic
  other,
}

extension ProductTypeExtension on ProductType {
  String get displayName => switch (this) {
    ProductType.freshProduce => 'Свежие продукты',
    ProductType.drinks => 'Напитки',
    ProductType.snacks => 'Закуски',
    ProductType.dairy => 'Молочные продукты',
    ProductType.canned => 'Консервы',
    ProductType.bakery => 'Выпечка',
    ProductType.cleaning => 'Уборка',
    ProductType.paperProducts => 'Бумажные товары',
    ProductType.airFresheners => 'Ароматизаторы',
    ProductType.kitchenSupplies => 'Кухонные принадлежности',
    ProductType.hygiene => 'Гигиена',
    ProductType.skincare => 'Уход за кожей',
    ProductType.medicine => 'Медицина',
    ProductType.cosmetics => 'Косметика',
    ProductType.petFood => 'Для животных',
    ProductType.petCare => 'Уход за животными',
    ProductType.petToys => 'Игрушки для животных',
    ProductType.diapers => 'Подгузники',
    ProductType.babyFood => 'Для детей',
    ProductType.babyCare => 'Уход за детьми',
    ProductType.babyToys => 'Игрушки для детей',
    ProductType.other => 'Другое',
  };

  int get id => switch (this) {
    ProductType.freshProduce => 1,
    ProductType.drinks => 2,
    ProductType.snacks => 3,
    ProductType.dairy => 4,
    ProductType.canned => 5,
    ProductType.bakery => 6,
    ProductType.cleaning => 7,
    ProductType.paperProducts => 8,
    ProductType.airFresheners => 9,
    ProductType.kitchenSupplies => 10,
    ProductType.hygiene => 11,
    ProductType.skincare => 12,
    ProductType.medicine => 13,
    ProductType.cosmetics => 14,
    ProductType.petFood => 15,
    ProductType.petCare => 16,
    ProductType.petToys => 17,
    ProductType.diapers => 18,
    ProductType.babyFood => 19,
    ProductType.babyCare => 20,
    ProductType.babyToys => 21,
    ProductType.other => 99,
  };

  ProductCategory get category => switch (this) {
    // Food
    ProductType.freshProduce => ProductCategory.food,
    ProductType.drinks => ProductCategory.food,
    ProductType.snacks => ProductCategory.food,
    ProductType.dairy => ProductCategory.food,
    ProductType.canned => ProductCategory.food,
    ProductType.bakery => ProductCategory.food,

    // Home
    ProductType.cleaning => ProductCategory.home,
    ProductType.paperProducts => ProductCategory.home,
    ProductType.airFresheners => ProductCategory.home,
    ProductType.kitchenSupplies => ProductCategory.home,

    // Personal
    ProductType.hygiene => ProductCategory.personal,
    ProductType.skincare => ProductCategory.personal,
    ProductType.medicine => ProductCategory.personal,
    ProductType.cosmetics => ProductCategory.personal,

    // Pets
    ProductType.petFood => ProductCategory.pets,
    ProductType.petCare => ProductCategory.pets,
    ProductType.petToys => ProductCategory.pets,

    // Baby
    ProductType.diapers => ProductCategory.baby,
    ProductType.babyFood => ProductCategory.baby,
    ProductType.babyCare => ProductCategory.baby,
    ProductType.babyToys => ProductCategory.baby,

    // Other
    ProductType.other => ProductCategory.other,
  };
}

extension ProductTypeUtils on ProductType {
  /// Возвращает все типы продуктов, сгруппированные по категориям
  static Map<ProductCategory, List<ProductType>> get groupedByCategory {
    return {
      ProductCategory.food: [
        ProductType.freshProduce,
        ProductType.drinks,
        ProductType.snacks,
        ProductType.dairy,
        ProductType.canned,
        ProductType.bakery,
      ],
      ProductCategory.home: [
        ProductType.cleaning,
        ProductType.paperProducts,
        ProductType.airFresheners,
        ProductType.kitchenSupplies,
      ],
      ProductCategory.personal: [
        ProductType.hygiene,
        ProductType.skincare,
        ProductType.medicine,
        ProductType.cosmetics,
      ],
      ProductCategory.pets: [ProductType.petFood, ProductType.petCare, ProductType.petToys],
      ProductCategory.baby: [ProductType.diapers, ProductType.babyFood, ProductType.babyCare, ProductType.babyToys],
      ProductCategory.other: [ProductType.other],
    };
  }

  /// Возвращает список всех типов продуктов для указанной категории
  static List<ProductType> getTypesForCategory(ProductCategory category) {
    return groupedByCategory[category] ?? [];
  }
}

class ProductTypeHelper {
  static ProductType fromId(int id) => ProductType.values.firstWhere((element) => element.id == id);
}
