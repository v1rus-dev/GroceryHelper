import 'package:equatable/equatable.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class AppProductType extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;

  const AppProductType({required this.id, required this.name, required this.category});

  @override
  List<Object?> get props => [id, name, category];
}

extension AppProductTypeExtension on AppProductType {
  String get displayName => name;
}
