// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductItemsTableTable extends ProductItemsTable
    with TableInfo<$ProductItemsTableTable, ProductItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProductCategory, int>
  productCategoryId =
      GeneratedColumn<int>(
        'product_category_id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ProductCategory>(
        $ProductItemsTableTable.$converterproductCategoryId,
      );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    productCategoryId,
    itemId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      productCategoryId: $ProductItemsTableTable.$converterproductCategoryId
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}product_category_id'],
            )!,
          ),
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductItemsTableTable createAlias(String alias) {
    return $ProductItemsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductCategory, int> $converterproductCategoryId =
      const ProductCategoryConverter();
}

class ProductItemsTableData extends DataClass
    implements Insertable<ProductItemsTableData> {
  final int id;
  final String name;
  final ProductCategory productCategoryId;
  final int itemId;
  final DateTime createdAt;
  const ProductItemsTableData({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.itemId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['product_category_id'] = Variable<int>(
        $ProductItemsTableTable.$converterproductCategoryId.toSql(
          productCategoryId,
        ),
      );
    }
    map['item_id'] = Variable<int>(itemId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductItemsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductItemsTableCompanion(
      id: Value(id),
      name: Value(name),
      productCategoryId: Value(productCategoryId),
      itemId: Value(itemId),
      createdAt: Value(createdAt),
    );
  }

  factory ProductItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductItemsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      productCategoryId: serializer.fromJson<ProductCategory>(
        json['productCategoryId'],
      ),
      itemId: serializer.fromJson<int>(json['itemId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'productCategoryId': serializer.toJson<ProductCategory>(
        productCategoryId,
      ),
      'itemId': serializer.toJson<int>(itemId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductItemsTableData copyWith({
    int? id,
    String? name,
    ProductCategory? productCategoryId,
    int? itemId,
    DateTime? createdAt,
  }) => ProductItemsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    productCategoryId: productCategoryId ?? this.productCategoryId,
    itemId: itemId ?? this.itemId,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductItemsTableData copyWithCompanion(ProductItemsTableCompanion data) {
    return ProductItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      productCategoryId: data.productCategoryId.present
          ? data.productCategoryId.value
          : this.productCategoryId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('itemId: $itemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, productCategoryId, itemId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductItemsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.productCategoryId == this.productCategoryId &&
          other.itemId == this.itemId &&
          other.createdAt == this.createdAt);
}

class ProductItemsTableCompanion
    extends UpdateCompanion<ProductItemsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<ProductCategory> productCategoryId;
  final Value<int> itemId;
  final Value<DateTime> createdAt;
  const ProductItemsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.productCategoryId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductItemsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ProductCategory productCategoryId,
    required int itemId,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       productCategoryId = Value(productCategoryId),
       itemId = Value(itemId);
  static Insertable<ProductItemsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? productCategoryId,
    Expression<int>? itemId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (productCategoryId != null) 'product_category_id': productCategoryId,
      if (itemId != null) 'item_id': itemId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductItemsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<ProductCategory>? productCategoryId,
    Value<int>? itemId,
    Value<DateTime>? createdAt,
  }) {
    return ProductItemsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      itemId: itemId ?? this.itemId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (productCategoryId.present) {
      map['product_category_id'] = Variable<int>(
        $ProductItemsTableTable.$converterproductCategoryId.toSql(
          productCategoryId.value,
        ),
      );
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('itemId: $itemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTableTable extends TagsTable
    with TableInfo<$TagsTableTable, TagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTableTable createAlias(String alias) {
    return $TagsTableTable(attachedDatabase, alias);
  }
}

class TagsTableData extends DataClass implements Insertable<TagsTableData> {
  final int id;
  final String name;
  final DateTime createdAt;
  const TagsTableData({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TagsTableCompanion toCompanion(bool nullToAbsent) {
    return TagsTableCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory TagsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TagsTableData copyWith({int? id, String? name, DateTime? createdAt}) =>
      TagsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  TagsTableData copyWithCompanion(TagsTableCompanion data) {
    return TagsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class TagsTableCompanion extends UpdateCompanion<TagsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const TagsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TagsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TagsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TagsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return TagsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductItemTagsTableTable extends ProductItemTagsTable
    with TableInfo<$ProductItemTagsTableTable, ProductItemTagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductItemTagsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productItemIdMeta = const VerificationMeta(
    'productItemId',
  );
  @override
  late final GeneratedColumn<int> productItemId = GeneratedColumn<int>(
    'product_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_items_table (id)',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [productItemId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_item_tags_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductItemTagsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_item_id')) {
      context.handle(
        _productItemIdMeta,
        productItemId.isAcceptableOrUnknown(
          data['product_item_id']!,
          _productItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productItemIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productItemId, tagId};
  @override
  ProductItemTagsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductItemTagsTableData(
      productItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_item_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ProductItemTagsTableTable createAlias(String alias) {
    return $ProductItemTagsTableTable(attachedDatabase, alias);
  }
}

class ProductItemTagsTableData extends DataClass
    implements Insertable<ProductItemTagsTableData> {
  final int productItemId;
  final int tagId;
  const ProductItemTagsTableData({
    required this.productItemId,
    required this.tagId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_item_id'] = Variable<int>(productItemId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  ProductItemTagsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductItemTagsTableCompanion(
      productItemId: Value(productItemId),
      tagId: Value(tagId),
    );
  }

  factory ProductItemTagsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductItemTagsTableData(
      productItemId: serializer.fromJson<int>(json['productItemId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productItemId': serializer.toJson<int>(productItemId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  ProductItemTagsTableData copyWith({int? productItemId, int? tagId}) =>
      ProductItemTagsTableData(
        productItemId: productItemId ?? this.productItemId,
        tagId: tagId ?? this.tagId,
      );
  ProductItemTagsTableData copyWithCompanion(
    ProductItemTagsTableCompanion data,
  ) {
    return ProductItemTagsTableData(
      productItemId: data.productItemId.present
          ? data.productItemId.value
          : this.productItemId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemTagsTableData(')
          ..write('productItemId: $productItemId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productItemId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductItemTagsTableData &&
          other.productItemId == this.productItemId &&
          other.tagId == this.tagId);
}

class ProductItemTagsTableCompanion
    extends UpdateCompanion<ProductItemTagsTableData> {
  final Value<int> productItemId;
  final Value<int> tagId;
  final Value<int> rowid;
  const ProductItemTagsTableCompanion({
    this.productItemId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductItemTagsTableCompanion.insert({
    required int productItemId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : productItemId = Value(productItemId),
       tagId = Value(tagId);
  static Insertable<ProductItemTagsTableData> custom({
    Expression<int>? productItemId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productItemId != null) 'product_item_id': productItemId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductItemTagsTableCompanion copyWith({
    Value<int>? productItemId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return ProductItemTagsTableCompanion(
      productItemId: productItemId ?? this.productItemId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productItemId.present) {
      map['product_item_id'] = Variable<int>(productItemId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemTagsTableCompanion(')
          ..write('productItemId: $productItemId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductTypesTableTable extends ProductTypesTable
    with TableInfo<$ProductTypesTableTable, ProductTypesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProductCategory, int>
  productCategory =
      GeneratedColumn<int>(
        'product_category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ProductCategory>(
        $ProductTypesTableTable.$converterproductCategory,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProductType?, int> productType =
      GeneratedColumn<int>(
        'product_type',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ProductType?>(
        $ProductTypesTableTable.$converterproductTypen,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    productCategory,
    createdAt,
    isCustom,
    productType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_types_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductTypesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTypesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTypesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      productCategory: $ProductTypesTableTable.$converterproductCategory
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}product_category'],
            )!,
          ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      productType: $ProductTypesTableTable.$converterproductTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_type'],
        ),
      ),
    );
  }

  @override
  $ProductTypesTableTable createAlias(String alias) {
    return $ProductTypesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductCategory, int> $converterproductCategory =
      const ProductCategoryConverter();
  static TypeConverter<ProductType, int> $converterproductType =
      const ProductTypeConverter();
  static TypeConverter<ProductType?, int?> $converterproductTypen =
      NullAwareTypeConverter.wrap($converterproductType);
}

class ProductTypesTableData extends DataClass
    implements Insertable<ProductTypesTableData> {
  final int id;
  final String name;
  final ProductCategory productCategory;
  final DateTime createdAt;
  final bool isCustom;
  final ProductType? productType;
  const ProductTypesTableData({
    required this.id,
    required this.name,
    required this.productCategory,
    required this.createdAt,
    required this.isCustom,
    this.productType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['product_category'] = Variable<int>(
        $ProductTypesTableTable.$converterproductCategory.toSql(
          productCategory,
        ),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || productType != null) {
      map['product_type'] = Variable<int>(
        $ProductTypesTableTable.$converterproductTypen.toSql(productType),
      );
    }
    return map;
  }

  ProductTypesTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTypesTableCompanion(
      id: Value(id),
      name: Value(name),
      productCategory: Value(productCategory),
      createdAt: Value(createdAt),
      isCustom: Value(isCustom),
      productType: productType == null && nullToAbsent
          ? const Value.absent()
          : Value(productType),
    );
  }

  factory ProductTypesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTypesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      productCategory: serializer.fromJson<ProductCategory>(
        json['productCategory'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      productType: serializer.fromJson<ProductType?>(json['productType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'productCategory': serializer.toJson<ProductCategory>(productCategory),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isCustom': serializer.toJson<bool>(isCustom),
      'productType': serializer.toJson<ProductType?>(productType),
    };
  }

  ProductTypesTableData copyWith({
    int? id,
    String? name,
    ProductCategory? productCategory,
    DateTime? createdAt,
    bool? isCustom,
    Value<ProductType?> productType = const Value.absent(),
  }) => ProductTypesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    productCategory: productCategory ?? this.productCategory,
    createdAt: createdAt ?? this.createdAt,
    isCustom: isCustom ?? this.isCustom,
    productType: productType.present ? productType.value : this.productType,
  );
  ProductTypesTableData copyWithCompanion(ProductTypesTableCompanion data) {
    return ProductTypesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      productCategory: data.productCategory.present
          ? data.productCategory.value
          : this.productCategory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      productType: data.productType.present
          ? data.productType.value
          : this.productType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategory: $productCategory, ')
          ..write('createdAt: $createdAt, ')
          ..write('isCustom: $isCustom, ')
          ..write('productType: $productType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, productCategory, createdAt, isCustom, productType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTypesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.productCategory == this.productCategory &&
          other.createdAt == this.createdAt &&
          other.isCustom == this.isCustom &&
          other.productType == this.productType);
}

class ProductTypesTableCompanion
    extends UpdateCompanion<ProductTypesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<ProductCategory> productCategory;
  final Value<DateTime> createdAt;
  final Value<bool> isCustom;
  final Value<ProductType?> productType;
  const ProductTypesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.productCategory = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.productType = const Value.absent(),
  });
  ProductTypesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ProductCategory productCategory,
    this.createdAt = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.productType = const Value.absent(),
  }) : name = Value(name),
       productCategory = Value(productCategory);
  static Insertable<ProductTypesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? productCategory,
    Expression<DateTime>? createdAt,
    Expression<bool>? isCustom,
    Expression<int>? productType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (productCategory != null) 'product_category': productCategory,
      if (createdAt != null) 'created_at': createdAt,
      if (isCustom != null) 'is_custom': isCustom,
      if (productType != null) 'product_type': productType,
    });
  }

  ProductTypesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<ProductCategory>? productCategory,
    Value<DateTime>? createdAt,
    Value<bool>? isCustom,
    Value<ProductType?>? productType,
  }) {
    return ProductTypesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      productCategory: productCategory ?? this.productCategory,
      createdAt: createdAt ?? this.createdAt,
      isCustom: isCustom ?? this.isCustom,
      productType: productType ?? this.productType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (productCategory.present) {
      map['product_category'] = Variable<int>(
        $ProductTypesTableTable.$converterproductCategory.toSql(
          productCategory.value,
        ),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (productType.present) {
      map['product_type'] = Variable<int>(
        $ProductTypesTableTable.$converterproductTypen.toSql(productType.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategory: $productCategory, ')
          ..write('createdAt: $createdAt, ')
          ..write('isCustom: $isCustom, ')
          ..write('productType: $productType')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductItemsTableTable productItemsTable =
      $ProductItemsTableTable(this);
  late final $TagsTableTable tagsTable = $TagsTableTable(this);
  late final $ProductItemTagsTableTable productItemTagsTable =
      $ProductItemTagsTableTable(this);
  late final $ProductTypesTableTable productTypesTable =
      $ProductTypesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productItemsTable,
    tagsTable,
    productItemTagsTable,
    productTypesTable,
  ];
}

typedef $$ProductItemsTableTableCreateCompanionBuilder =
    ProductItemsTableCompanion Function({
      Value<int> id,
      required String name,
      required ProductCategory productCategoryId,
      required int itemId,
      Value<DateTime> createdAt,
    });
typedef $$ProductItemsTableTableUpdateCompanionBuilder =
    ProductItemsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<ProductCategory> productCategoryId,
      Value<int> itemId,
      Value<DateTime> createdAt,
    });

final class $$ProductItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductItemsTableTable,
          ProductItemsTableData
        > {
  $$ProductItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ProductItemTagsTableTable,
    List<ProductItemTagsTableData>
  >
  _productItemTagsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productItemTagsTable,
        aliasName: $_aliasNameGenerator(
          db.productItemsTable.id,
          db.productItemTagsTable.productItemId,
        ),
      );

  $$ProductItemTagsTableTableProcessedTableManager
  get productItemTagsTableRefs {
    final manager = $$ProductItemTagsTableTableTableManager(
      $_db,
      $_db.productItemTagsTable,
    ).filter((f) => f.productItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productItemTagsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductItemsTableTable> {
  $$ProductItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProductCategory, ProductCategory, int>
  get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productItemTagsTableRefs(
    Expression<bool> Function($$ProductItemTagsTableTableFilterComposer f) f,
  ) {
    final $$ProductItemTagsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productItemTagsTable,
      getReferencedColumn: (t) => t.productItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductItemTagsTableTableFilterComposer(
            $db: $db,
            $table: $db.productItemTagsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductItemsTableTable> {
  $$ProductItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductItemsTableTable> {
  $$ProductItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductCategory, int>
  get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> productItemTagsTableRefs<T extends Object>(
    Expression<T> Function($$ProductItemTagsTableTableAnnotationComposer a) f,
  ) {
    final $$ProductItemTagsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productItemTagsTable,
          getReferencedColumn: (t) => t.productItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductItemTagsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.productItemTagsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductItemsTableTable,
          ProductItemsTableData,
          $$ProductItemsTableTableFilterComposer,
          $$ProductItemsTableTableOrderingComposer,
          $$ProductItemsTableTableAnnotationComposer,
          $$ProductItemsTableTableCreateCompanionBuilder,
          $$ProductItemsTableTableUpdateCompanionBuilder,
          (ProductItemsTableData, $$ProductItemsTableTableReferences),
          ProductItemsTableData,
          PrefetchHooks Function({bool productItemTagsTableRefs})
        > {
  $$ProductItemsTableTableTableManager(
    _$AppDatabase db,
    $ProductItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ProductCategory> productCategoryId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductItemsTableCompanion(
                id: id,
                name: name,
                productCategoryId: productCategoryId,
                itemId: itemId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required ProductCategory productCategoryId,
                required int itemId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductItemsTableCompanion.insert(
                id: id,
                name: name,
                productCategoryId: productCategoryId,
                itemId: itemId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productItemTagsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productItemTagsTableRefs) db.productItemTagsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productItemTagsTableRefs)
                    await $_getPrefetchedData<
                      ProductItemsTableData,
                      $ProductItemsTableTable,
                      ProductItemTagsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$ProductItemsTableTableReferences
                          ._productItemTagsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductItemsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).productItemTagsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.productItemId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductItemsTableTable,
      ProductItemsTableData,
      $$ProductItemsTableTableFilterComposer,
      $$ProductItemsTableTableOrderingComposer,
      $$ProductItemsTableTableAnnotationComposer,
      $$ProductItemsTableTableCreateCompanionBuilder,
      $$ProductItemsTableTableUpdateCompanionBuilder,
      (ProductItemsTableData, $$ProductItemsTableTableReferences),
      ProductItemsTableData,
      PrefetchHooks Function({bool productItemTagsTableRefs})
    >;
typedef $$TagsTableTableCreateCompanionBuilder =
    TagsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
    });
typedef $$TagsTableTableUpdateCompanionBuilder =
    TagsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
    });

final class $$TagsTableTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTableTable, TagsTableData> {
  $$TagsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ProductItemTagsTableTable,
    List<ProductItemTagsTableData>
  >
  _productItemTagsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productItemTagsTable,
        aliasName: $_aliasNameGenerator(
          db.tagsTable.id,
          db.productItemTagsTable.tagId,
        ),
      );

  $$ProductItemTagsTableTableProcessedTableManager
  get productItemTagsTableRefs {
    final manager = $$ProductItemTagsTableTableTableManager(
      $_db,
      $_db.productItemTagsTable,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productItemTagsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productItemTagsTableRefs(
    Expression<bool> Function($$ProductItemTagsTableTableFilterComposer f) f,
  ) {
    final $$ProductItemTagsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productItemTagsTable,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductItemTagsTableTableFilterComposer(
            $db: $db,
            $table: $db.productItemTagsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> productItemTagsTableRefs<T extends Object>(
    Expression<T> Function($$ProductItemTagsTableTableAnnotationComposer a) f,
  ) {
    final $$ProductItemTagsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productItemTagsTable,
          getReferencedColumn: (t) => t.tagId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductItemTagsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.productItemTagsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TagsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTableTable,
          TagsTableData,
          $$TagsTableTableFilterComposer,
          $$TagsTableTableOrderingComposer,
          $$TagsTableTableAnnotationComposer,
          $$TagsTableTableCreateCompanionBuilder,
          $$TagsTableTableUpdateCompanionBuilder,
          (TagsTableData, $$TagsTableTableReferences),
          TagsTableData,
          PrefetchHooks Function({bool productItemTagsTableRefs})
        > {
  $$TagsTableTableTableManager(_$AppDatabase db, $TagsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) =>
                  TagsTableCompanion(id: id, name: name, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsTableCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TagsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productItemTagsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productItemTagsTableRefs) db.productItemTagsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productItemTagsTableRefs)
                    await $_getPrefetchedData<
                      TagsTableData,
                      $TagsTableTable,
                      ProductItemTagsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$TagsTableTableReferences
                          ._productItemTagsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).productItemTagsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTableTable,
      TagsTableData,
      $$TagsTableTableFilterComposer,
      $$TagsTableTableOrderingComposer,
      $$TagsTableTableAnnotationComposer,
      $$TagsTableTableCreateCompanionBuilder,
      $$TagsTableTableUpdateCompanionBuilder,
      (TagsTableData, $$TagsTableTableReferences),
      TagsTableData,
      PrefetchHooks Function({bool productItemTagsTableRefs})
    >;
typedef $$ProductItemTagsTableTableCreateCompanionBuilder =
    ProductItemTagsTableCompanion Function({
      required int productItemId,
      required int tagId,
      Value<int> rowid,
    });
typedef $$ProductItemTagsTableTableUpdateCompanionBuilder =
    ProductItemTagsTableCompanion Function({
      Value<int> productItemId,
      Value<int> tagId,
      Value<int> rowid,
    });

final class $$ProductItemTagsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductItemTagsTableTable,
          ProductItemTagsTableData
        > {
  $$ProductItemTagsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductItemsTableTable _productItemIdTable(_$AppDatabase db) =>
      db.productItemsTable.createAlias(
        $_aliasNameGenerator(
          db.productItemTagsTable.productItemId,
          db.productItemsTable.id,
        ),
      );

  $$ProductItemsTableTableProcessedTableManager get productItemId {
    final $_column = $_itemColumn<int>('product_item_id')!;

    final manager = $$ProductItemsTableTableTableManager(
      $_db,
      $_db.productItemsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTableTable _tagIdTable(_$AppDatabase db) =>
      db.tagsTable.createAlias(
        $_aliasNameGenerator(db.productItemTagsTable.tagId, db.tagsTable.id),
      );

  $$TagsTableTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableTableManager(
      $_db,
      $_db.tagsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductItemTagsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTableTable> {
  $$ProductItemTagsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductItemsTableTableFilterComposer get productItemId {
    final $$ProductItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productItemId,
      referencedTable: $db.productItemsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.productItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableTableFilterComposer get tagId {
    final $$TagsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tagsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableTableFilterComposer(
            $db: $db,
            $table: $db.tagsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductItemTagsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTableTable> {
  $$ProductItemTagsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductItemsTableTableOrderingComposer get productItemId {
    final $$ProductItemsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productItemId,
      referencedTable: $db.productItemsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductItemsTableTableOrderingComposer(
            $db: $db,
            $table: $db.productItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableTableOrderingComposer get tagId {
    final $$TagsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tagsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableTableOrderingComposer(
            $db: $db,
            $table: $db.tagsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductItemTagsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTableTable> {
  $$ProductItemTagsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductItemsTableTableAnnotationComposer get productItemId {
    final $$ProductItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.productItemId,
          referencedTable: $db.productItemsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.productItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TagsTableTableAnnotationComposer get tagId {
    final $$TagsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tagsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.tagsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductItemTagsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductItemTagsTableTable,
          ProductItemTagsTableData,
          $$ProductItemTagsTableTableFilterComposer,
          $$ProductItemTagsTableTableOrderingComposer,
          $$ProductItemTagsTableTableAnnotationComposer,
          $$ProductItemTagsTableTableCreateCompanionBuilder,
          $$ProductItemTagsTableTableUpdateCompanionBuilder,
          (ProductItemTagsTableData, $$ProductItemTagsTableTableReferences),
          ProductItemTagsTableData,
          PrefetchHooks Function({bool productItemId, bool tagId})
        > {
  $$ProductItemTagsTableTableTableManager(
    _$AppDatabase db,
    $ProductItemTagsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductItemTagsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductItemTagsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductItemTagsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> productItemId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductItemTagsTableCompanion(
                productItemId: productItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productItemId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => ProductItemTagsTableCompanion.insert(
                productItemId: productItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductItemTagsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productItemId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productItemId,
                                referencedTable:
                                    $$ProductItemTagsTableTableReferences
                                        ._productItemIdTable(db),
                                referencedColumn:
                                    $$ProductItemTagsTableTableReferences
                                        ._productItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable:
                                    $$ProductItemTagsTableTableReferences
                                        ._tagIdTable(db),
                                referencedColumn:
                                    $$ProductItemTagsTableTableReferences
                                        ._tagIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductItemTagsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductItemTagsTableTable,
      ProductItemTagsTableData,
      $$ProductItemTagsTableTableFilterComposer,
      $$ProductItemTagsTableTableOrderingComposer,
      $$ProductItemTagsTableTableAnnotationComposer,
      $$ProductItemTagsTableTableCreateCompanionBuilder,
      $$ProductItemTagsTableTableUpdateCompanionBuilder,
      (ProductItemTagsTableData, $$ProductItemTagsTableTableReferences),
      ProductItemTagsTableData,
      PrefetchHooks Function({bool productItemId, bool tagId})
    >;
typedef $$ProductTypesTableTableCreateCompanionBuilder =
    ProductTypesTableCompanion Function({
      Value<int> id,
      required String name,
      required ProductCategory productCategory,
      Value<DateTime> createdAt,
      Value<bool> isCustom,
      Value<ProductType?> productType,
    });
typedef $$ProductTypesTableTableUpdateCompanionBuilder =
    ProductTypesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<ProductCategory> productCategory,
      Value<DateTime> createdAt,
      Value<bool> isCustom,
      Value<ProductType?> productType,
    });

class $$ProductTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTypesTableTable> {
  $$ProductTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProductCategory, ProductCategory, int>
  get productCategory => $composableBuilder(
    column: $table.productCategory,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProductType?, ProductType, int>
  get productType => $composableBuilder(
    column: $table.productType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ProductTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTypesTableTable> {
  $$ProductTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productCategory => $composableBuilder(
    column: $table.productCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productType => $composableBuilder(
    column: $table.productType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTypesTableTable> {
  $$ProductTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductCategory, int> get productCategory =>
      $composableBuilder(
        column: $table.productCategory,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductType?, int> get productType =>
      $composableBuilder(
        column: $table.productType,
        builder: (column) => column,
      );
}

class $$ProductTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTypesTableTable,
          ProductTypesTableData,
          $$ProductTypesTableTableFilterComposer,
          $$ProductTypesTableTableOrderingComposer,
          $$ProductTypesTableTableAnnotationComposer,
          $$ProductTypesTableTableCreateCompanionBuilder,
          $$ProductTypesTableTableUpdateCompanionBuilder,
          (
            ProductTypesTableData,
            BaseReferences<
              _$AppDatabase,
              $ProductTypesTableTable,
              ProductTypesTableData
            >,
          ),
          ProductTypesTableData,
          PrefetchHooks Function()
        > {
  $$ProductTypesTableTableTableManager(
    _$AppDatabase db,
    $ProductTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTypesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTypesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ProductCategory> productCategory = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<ProductType?> productType = const Value.absent(),
              }) => ProductTypesTableCompanion(
                id: id,
                name: name,
                productCategory: productCategory,
                createdAt: createdAt,
                isCustom: isCustom,
                productType: productType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required ProductCategory productCategory,
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<ProductType?> productType = const Value.absent(),
              }) => ProductTypesTableCompanion.insert(
                id: id,
                name: name,
                productCategory: productCategory,
                createdAt: createdAt,
                isCustom: isCustom,
                productType: productType,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTypesTableTable,
      ProductTypesTableData,
      $$ProductTypesTableTableFilterComposer,
      $$ProductTypesTableTableOrderingComposer,
      $$ProductTypesTableTableAnnotationComposer,
      $$ProductTypesTableTableCreateCompanionBuilder,
      $$ProductTypesTableTableUpdateCompanionBuilder,
      (
        ProductTypesTableData,
        BaseReferences<
          _$AppDatabase,
          $ProductTypesTableTable,
          ProductTypesTableData
        >,
      ),
      ProductTypesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductItemsTableTableTableManager get productItemsTable =>
      $$ProductItemsTableTableTableManager(_db, _db.productItemsTable);
  $$TagsTableTableTableManager get tagsTable =>
      $$TagsTableTableTableManager(_db, _db.tagsTable);
  $$ProductItemTagsTableTableTableManager get productItemTagsTable =>
      $$ProductItemTagsTableTableTableManager(_db, _db.productItemTagsTable);
  $$ProductTypesTableTableTableManager get productTypesTable =>
      $$ProductTypesTableTableTableManager(_db, _db.productTypesTable);
}
