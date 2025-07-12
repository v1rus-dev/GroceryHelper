import 'package:flutter/material.dart';

enum ProductCategory { food, home, personal, pets, baby, other }

extension ProductCategoryExtension on ProductCategory {
  String get displayName => switch (this) {
    ProductCategory.food => 'Еда',
    ProductCategory.home => 'Дом',
    ProductCategory.personal => 'Личные вещи',
    ProductCategory.pets => 'Животные',
    ProductCategory.baby => 'Для детей',
    ProductCategory.other => 'Другое',
  };

  int get id => switch (this) {
    ProductCategory.food => 1,
    ProductCategory.home => 2,
    ProductCategory.personal => 3,
    ProductCategory.pets => 4,
    ProductCategory.baby => 5,
    ProductCategory.other => 99,
  };

  Color get color => switch (this) {
    ProductCategory.food => Color(0xFF0AB90A),
    ProductCategory.home => Color(0xFF007AFF),
    ProductCategory.personal => Color(0xFF5856D6),
    ProductCategory.pets => Color(0xFFF2994A),
    ProductCategory.baby => Color(0xFFEB5757),
    ProductCategory.other => Color(0xFF828282),
  };
}

class ProductCategoryHelper {
  static ProductCategory fromId(int id) => ProductCategory.values.firstWhere((element) => element.id == id);
}
