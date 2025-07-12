// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductItemsTable extends ProductItems
    with TableInfo<$ProductItemsTable, ProductItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductItemsTable(this.attachedDatabase, [this._alias]);
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
        $ProductItemsTable.$converterproductCategoryId,
      );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const String $name = 'product_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductItem> instance, {
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
  ProductItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      productCategoryId: $ProductItemsTable.$converterproductCategoryId.fromSql(
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
  $ProductItemsTable createAlias(String alias) {
    return $ProductItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductCategory, int> $converterproductCategoryId =
      const ProductCategoryConverter();
}

class ProductItem extends DataClass implements Insertable<ProductItem> {
  final int id;
  final String name;
  final ProductCategory productCategoryId;
  final int itemId;
  final DateTime createdAt;
  const ProductItem({
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
        $ProductItemsTable.$converterproductCategoryId.toSql(productCategoryId),
      );
    }
    map['item_id'] = Variable<int>(itemId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductItemsCompanion toCompanion(bool nullToAbsent) {
    return ProductItemsCompanion(
      id: Value(id),
      name: Value(name),
      productCategoryId: Value(productCategoryId),
      itemId: Value(itemId),
      createdAt: Value(createdAt),
    );
  }

  factory ProductItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductItem(
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

  ProductItem copyWith({
    int? id,
    String? name,
    ProductCategory? productCategoryId,
    int? itemId,
    DateTime? createdAt,
  }) => ProductItem(
    id: id ?? this.id,
    name: name ?? this.name,
    productCategoryId: productCategoryId ?? this.productCategoryId,
    itemId: itemId ?? this.itemId,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductItem copyWithCompanion(ProductItemsCompanion data) {
    return ProductItem(
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
    return (StringBuffer('ProductItem(')
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
      (other is ProductItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.productCategoryId == this.productCategoryId &&
          other.itemId == this.itemId &&
          other.createdAt == this.createdAt);
}

class ProductItemsCompanion extends UpdateCompanion<ProductItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<ProductCategory> productCategoryId;
  final Value<int> itemId;
  final Value<DateTime> createdAt;
  const ProductItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.productCategoryId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ProductCategory productCategoryId,
    required int itemId,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       productCategoryId = Value(productCategoryId),
       itemId = Value(itemId);
  static Insertable<ProductItem> custom({
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

  ProductItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<ProductCategory>? productCategoryId,
    Value<int>? itemId,
    Value<DateTime>? createdAt,
  }) {
    return ProductItemsCompanion(
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
        $ProductItemsTable.$converterproductCategoryId.toSql(
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
    return (StringBuffer('ProductItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('itemId: $itemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductItemTagsTable extends ProductItemTags
    with TableInfo<$ProductItemTagsTable, ProductItemTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductItemTagsTable(this.attachedDatabase, [this._alias]);
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
    $customConstraints: 'REFERENCES product_items(id)',
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES tags(id)',
  );
  @override
  List<GeneratedColumn> get $columns => [productItemId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_item_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductItemTag> instance, {
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
  ProductItemTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductItemTag(
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
  $ProductItemTagsTable createAlias(String alias) {
    return $ProductItemTagsTable(attachedDatabase, alias);
  }
}

class ProductItemTag extends DataClass implements Insertable<ProductItemTag> {
  final int productItemId;
  final int tagId;
  const ProductItemTag({required this.productItemId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_item_id'] = Variable<int>(productItemId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  ProductItemTagsCompanion toCompanion(bool nullToAbsent) {
    return ProductItemTagsCompanion(
      productItemId: Value(productItemId),
      tagId: Value(tagId),
    );
  }

  factory ProductItemTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductItemTag(
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

  ProductItemTag copyWith({int? productItemId, int? tagId}) => ProductItemTag(
    productItemId: productItemId ?? this.productItemId,
    tagId: tagId ?? this.tagId,
  );
  ProductItemTag copyWithCompanion(ProductItemTagsCompanion data) {
    return ProductItemTag(
      productItemId: data.productItemId.present
          ? data.productItemId.value
          : this.productItemId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemTag(')
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
      (other is ProductItemTag &&
          other.productItemId == this.productItemId &&
          other.tagId == this.tagId);
}

class ProductItemTagsCompanion extends UpdateCompanion<ProductItemTag> {
  final Value<int> productItemId;
  final Value<int> tagId;
  final Value<int> rowid;
  const ProductItemTagsCompanion({
    this.productItemId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductItemTagsCompanion.insert({
    required int productItemId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : productItemId = Value(productItemId),
       tagId = Value(tagId);
  static Insertable<ProductItemTag> custom({
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

  ProductItemTagsCompanion copyWith({
    Value<int>? productItemId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return ProductItemTagsCompanion(
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
    return (StringBuffer('ProductItemTagsCompanion(')
          ..write('productItemId: $productItemId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
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

class $ProductTypesTable extends ProductTypes
    with TableInfo<$ProductTypesTable, ProductType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTypesTable(this.attachedDatabase, [this._alias]);
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
        $ProductTypesTable.$converterproductCategory,
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
  List<GeneratedColumn> get $columns => [id, name, productCategory, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductType> instance, {
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
  ProductType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      productCategory: $ProductTypesTable.$converterproductCategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}product_category'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductTypesTable createAlias(String alias) {
    return $ProductTypesTable(attachedDatabase, alias);
  }

  static TypeConverter<ProductCategory, int> $converterproductCategory =
      const ProductCategoryConverter();
}

class ProductType extends DataClass implements Insertable<ProductType> {
  final int id;
  final String name;
  final ProductCategory productCategory;
  final DateTime createdAt;
  const ProductType({
    required this.id,
    required this.name,
    required this.productCategory,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['product_category'] = Variable<int>(
        $ProductTypesTable.$converterproductCategory.toSql(productCategory),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductTypesCompanion toCompanion(bool nullToAbsent) {
    return ProductTypesCompanion(
      id: Value(id),
      name: Value(name),
      productCategory: Value(productCategory),
      createdAt: Value(createdAt),
    );
  }

  factory ProductType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      productCategory: serializer.fromJson<ProductCategory>(
        json['productCategory'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
    };
  }

  ProductType copyWith({
    int? id,
    String? name,
    ProductCategory? productCategory,
    DateTime? createdAt,
  }) => ProductType(
    id: id ?? this.id,
    name: name ?? this.name,
    productCategory: productCategory ?? this.productCategory,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductType copyWithCompanion(ProductTypesCompanion data) {
    return ProductType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      productCategory: data.productCategory.present
          ? data.productCategory.value
          : this.productCategory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategory: $productCategory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, productCategory, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductType &&
          other.id == this.id &&
          other.name == this.name &&
          other.productCategory == this.productCategory &&
          other.createdAt == this.createdAt);
}

class ProductTypesCompanion extends UpdateCompanion<ProductType> {
  final Value<int> id;
  final Value<String> name;
  final Value<ProductCategory> productCategory;
  final Value<DateTime> createdAt;
  const ProductTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.productCategory = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ProductCategory productCategory,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       productCategory = Value(productCategory);
  static Insertable<ProductType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? productCategory,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (productCategory != null) 'product_category': productCategory,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<ProductCategory>? productCategory,
    Value<DateTime>? createdAt,
  }) {
    return ProductTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      productCategory: productCategory ?? this.productCategory,
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
    if (productCategory.present) {
      map['product_category'] = Variable<int>(
        $ProductTypesTable.$converterproductCategory.toSql(
          productCategory.value,
        ),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('productCategory: $productCategory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductItemsTable productItems = $ProductItemsTable(this);
  late final $ProductItemTagsTable productItemTags = $ProductItemTagsTable(
    this,
  );
  late final $TagsTableTable tagsTable = $TagsTableTable(this);
  late final $ProductTypesTable productTypes = $ProductTypesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productItems,
    productItemTags,
    tagsTable,
    productTypes,
  ];
}

typedef $$ProductItemsTableCreateCompanionBuilder =
    ProductItemsCompanion Function({
      Value<int> id,
      required String name,
      required ProductCategory productCategoryId,
      required int itemId,
      Value<DateTime> createdAt,
    });
typedef $$ProductItemsTableUpdateCompanionBuilder =
    ProductItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<ProductCategory> productCategoryId,
      Value<int> itemId,
      Value<DateTime> createdAt,
    });

class $$ProductItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableFilterComposer({
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
}

class $$ProductItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableOrderingComposer({
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

class $$ProductItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableAnnotationComposer({
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
}

class $$ProductItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductItemsTable,
          ProductItem,
          $$ProductItemsTableFilterComposer,
          $$ProductItemsTableOrderingComposer,
          $$ProductItemsTableAnnotationComposer,
          $$ProductItemsTableCreateCompanionBuilder,
          $$ProductItemsTableUpdateCompanionBuilder,
          (
            ProductItem,
            BaseReferences<_$AppDatabase, $ProductItemsTable, ProductItem>,
          ),
          ProductItem,
          PrefetchHooks Function()
        > {
  $$ProductItemsTableTableManager(_$AppDatabase db, $ProductItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ProductCategory> productCategoryId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductItemsCompanion(
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
              }) => ProductItemsCompanion.insert(
                id: id,
                name: name,
                productCategoryId: productCategoryId,
                itemId: itemId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductItemsTable,
      ProductItem,
      $$ProductItemsTableFilterComposer,
      $$ProductItemsTableOrderingComposer,
      $$ProductItemsTableAnnotationComposer,
      $$ProductItemsTableCreateCompanionBuilder,
      $$ProductItemsTableUpdateCompanionBuilder,
      (
        ProductItem,
        BaseReferences<_$AppDatabase, $ProductItemsTable, ProductItem>,
      ),
      ProductItem,
      PrefetchHooks Function()
    >;
typedef $$ProductItemTagsTableCreateCompanionBuilder =
    ProductItemTagsCompanion Function({
      required int productItemId,
      required int tagId,
      Value<int> rowid,
    });
typedef $$ProductItemTagsTableUpdateCompanionBuilder =
    ProductItemTagsCompanion Function({
      Value<int> productItemId,
      Value<int> tagId,
      Value<int> rowid,
    });

class $$ProductItemTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTable> {
  $$ProductItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get productItemId => $composableBuilder(
    column: $table.productItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductItemTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTable> {
  $$ProductItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get productItemId => $composableBuilder(
    column: $table.productItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductItemTagsTable> {
  $$ProductItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get productItemId => $composableBuilder(
    column: $table.productItemId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$ProductItemTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductItemTagsTable,
          ProductItemTag,
          $$ProductItemTagsTableFilterComposer,
          $$ProductItemTagsTableOrderingComposer,
          $$ProductItemTagsTableAnnotationComposer,
          $$ProductItemTagsTableCreateCompanionBuilder,
          $$ProductItemTagsTableUpdateCompanionBuilder,
          (
            ProductItemTag,
            BaseReferences<
              _$AppDatabase,
              $ProductItemTagsTable,
              ProductItemTag
            >,
          ),
          ProductItemTag,
          PrefetchHooks Function()
        > {
  $$ProductItemTagsTableTableManager(
    _$AppDatabase db,
    $ProductItemTagsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> productItemId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductItemTagsCompanion(
                productItemId: productItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productItemId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => ProductItemTagsCompanion.insert(
                productItemId: productItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductItemTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductItemTagsTable,
      ProductItemTag,
      $$ProductItemTagsTableFilterComposer,
      $$ProductItemTagsTableOrderingComposer,
      $$ProductItemTagsTableAnnotationComposer,
      $$ProductItemTagsTableCreateCompanionBuilder,
      $$ProductItemTagsTableUpdateCompanionBuilder,
      (
        ProductItemTag,
        BaseReferences<_$AppDatabase, $ProductItemTagsTable, ProductItemTag>,
      ),
      ProductItemTag,
      PrefetchHooks Function()
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
          (
            TagsTableData,
            BaseReferences<_$AppDatabase, $TagsTableTable, TagsTableData>,
          ),
          TagsTableData,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        TagsTableData,
        BaseReferences<_$AppDatabase, $TagsTableTable, TagsTableData>,
      ),
      TagsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProductTypesTableCreateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      required String name,
      required ProductCategory productCategory,
      Value<DateTime> createdAt,
    });
typedef $$ProductTypesTableUpdateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<ProductCategory> productCategory,
      Value<DateTime> createdAt,
    });

class $$ProductTypesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableFilterComposer({
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
}

class $$ProductTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableOrderingComposer({
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
}

class $$ProductTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableAnnotationComposer({
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
}

class $$ProductTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTypesTable,
          ProductType,
          $$ProductTypesTableFilterComposer,
          $$ProductTypesTableOrderingComposer,
          $$ProductTypesTableAnnotationComposer,
          $$ProductTypesTableCreateCompanionBuilder,
          $$ProductTypesTableUpdateCompanionBuilder,
          (
            ProductType,
            BaseReferences<_$AppDatabase, $ProductTypesTable, ProductType>,
          ),
          ProductType,
          PrefetchHooks Function()
        > {
  $$ProductTypesTableTableManager(_$AppDatabase db, $ProductTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ProductCategory> productCategory = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductTypesCompanion(
                id: id,
                name: name,
                productCategory: productCategory,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required ProductCategory productCategory,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductTypesCompanion.insert(
                id: id,
                name: name,
                productCategory: productCategory,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTypesTable,
      ProductType,
      $$ProductTypesTableFilterComposer,
      $$ProductTypesTableOrderingComposer,
      $$ProductTypesTableAnnotationComposer,
      $$ProductTypesTableCreateCompanionBuilder,
      $$ProductTypesTableUpdateCompanionBuilder,
      (
        ProductType,
        BaseReferences<_$AppDatabase, $ProductTypesTable, ProductType>,
      ),
      ProductType,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductItemsTableTableManager get productItems =>
      $$ProductItemsTableTableManager(_db, _db.productItems);
  $$ProductItemTagsTableTableManager get productItemTags =>
      $$ProductItemTagsTableTableManager(_db, _db.productItemTags);
  $$TagsTableTableTableManager get tagsTable =>
      $$TagsTableTableTableManager(_db, _db.tagsTable);
  $$ProductTypesTableTableManager get productTypes =>
      $$ProductTypesTableTableManager(_db, _db.productTypes);
}
