import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';

sealed class AppProductType extends Equatable {}

class AppProductTypeDefault extends AppProductType {
  final ProductType type;

  AppProductTypeDefault({required this.type});

  @override
  List<Object?> get props => [type];
}

class AppProductTypeUser extends AppProductType {
  final int id;
  final String name;
  final ProductCategory category;

  AppProductTypeUser({required this.id, required this.name, required this.category});

  @override
  List<Object?> get props => [id, name, category];
}

extension AppProductTypeExtension on AppProductType {
  String get displayName => switch (this) {
    AppProductTypeDefault(:final type) => type.displayName,
    AppProductTypeUser(:final name) => name,
  };
}
