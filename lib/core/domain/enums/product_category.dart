enum ProductCategory {
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
  uncategorized,
}

extension ProductCategoryExtension on ProductCategory {
  String get displayName => switch (this) {
    ProductCategory.freshProduce => 'Свежее',
    ProductCategory.drinks => 'Напитки',
    ProductCategory.snacks => 'Закуски',
    ProductCategory.dairy => 'Молочные продукты',
    ProductCategory.canned => 'Консервы',
    ProductCategory.bakery => 'Выпечка',
    ProductCategory.cleaning => 'Уборка',
    ProductCategory.paperProducts => 'Бумажные товары',
    ProductCategory.airFresheners => 'Ароматизаторы',
    ProductCategory.kitchenSupplies => 'Кухонные принадлежности',
    ProductCategory.hygiene => 'Гигиена',
    ProductCategory.skincare => 'Уход за кожей',
    ProductCategory.medicine => 'Медицина',
    ProductCategory.cosmetics => 'Косметика',
    ProductCategory.petFood => 'Для животных',
    ProductCategory.petCare => 'Уход за животными',
    ProductCategory.petToys => 'Игрушки для животных',
    ProductCategory.diapers => 'Подгузники',
    ProductCategory.babyFood => 'Для детей',
    ProductCategory.babyCare => 'Уход за детьми',
    ProductCategory.babyToys => 'Игрушки для детей',
    ProductCategory.uncategorized => 'Без категории',
  };
}
