// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tidMeta = const VerificationMeta('tid');
  @override
  late final GeneratedColumn<int> tid = GeneratedColumn<int>(
      'tid', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<int> tax = GeneratedColumn<int>(
      'tax', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [tid, productName, category, price, tax];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  VerificationContext validateIntegrity(Insertable<ProductData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tid')) {
      context.handle(
          _tidMeta, tid.isAcceptableOrUnknown(data['tid']!, _tidMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
          _taxMeta, tax.isAcceptableOrUnknown(data['tax']!, _taxMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tid};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      tid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tid']),
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      tax: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tax']),
    );
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final int? tid;
  final String productName;
  final String category;
  final double price;
  final int? tax;
  const ProductData(
      {this.tid,
      required this.productName,
      required this.category,
      required this.price,
      this.tax});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || tid != null) {
      map['tid'] = Variable<int>(tid);
    }
    map['product_name'] = Variable<String>(productName);
    map['category'] = Variable<String>(category);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<int>(tax);
    }
    return map;
  }

  ProductTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      tid: tid == null && nullToAbsent ? const Value.absent() : Value(tid),
      productName: Value(productName),
      category: Value(category),
      price: Value(price),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      tid: serializer.fromJson<int?>(json['tid']),
      productName: serializer.fromJson<String>(json['productName']),
      category: serializer.fromJson<String>(json['category']),
      price: serializer.fromJson<double>(json['price']),
      tax: serializer.fromJson<int?>(json['tax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tid': serializer.toJson<int?>(tid),
      'productName': serializer.toJson<String>(productName),
      'category': serializer.toJson<String>(category),
      'price': serializer.toJson<double>(price),
      'tax': serializer.toJson<int?>(tax),
    };
  }

  ProductData copyWith(
          {Value<int?> tid = const Value.absent(),
          String? productName,
          String? category,
          double? price,
          Value<int?> tax = const Value.absent()}) =>
      ProductData(
        tid: tid.present ? tid.value : this.tid,
        productName: productName ?? this.productName,
        category: category ?? this.category,
        price: price ?? this.price,
        tax: tax.present ? tax.value : this.tax,
      );
  ProductData copyWithCompanion(ProductTableCompanion data) {
    return ProductData(
      tid: data.tid.present ? data.tid.value : this.tid,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      tax: data.tax.present ? data.tax.value : this.tax,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('tid: $tid, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('tax: $tax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tid, productName, category, price, tax);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.tid == this.tid &&
          other.productName == this.productName &&
          other.category == this.category &&
          other.price == this.price &&
          other.tax == this.tax);
}

class ProductTableCompanion extends UpdateCompanion<ProductData> {
  final Value<int?> tid;
  final Value<String> productName;
  final Value<String> category;
  final Value<double> price;
  final Value<int?> tax;
  const ProductTableCompanion({
    this.tid = const Value.absent(),
    this.productName = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.tax = const Value.absent(),
  });
  ProductTableCompanion.insert({
    this.tid = const Value.absent(),
    required String productName,
    required String category,
    required double price,
    this.tax = const Value.absent(),
  })  : productName = Value(productName),
        category = Value(category),
        price = Value(price);
  static Insertable<ProductData> custom({
    Expression<int>? tid,
    Expression<String>? productName,
    Expression<String>? category,
    Expression<double>? price,
    Expression<int>? tax,
  }) {
    return RawValuesInsertable({
      if (tid != null) 'tid': tid,
      if (productName != null) 'product_name': productName,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (tax != null) 'tax': tax,
    });
  }

  ProductTableCompanion copyWith(
      {Value<int?>? tid,
      Value<String>? productName,
      Value<String>? category,
      Value<double>? price,
      Value<int?>? tax}) {
    return ProductTableCompanion(
      tid: tid ?? this.tid,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      price: price ?? this.price,
      tax: tax ?? this.tax,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tid.present) {
      map['tid'] = Variable<int>(tid.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (tax.present) {
      map['tax'] = Variable<int>(tax.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableCompanion(')
          ..write('tid: $tid, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('tax: $tax')
          ..write(')'))
        .toString();
  }
}

class $OrdersTableTable extends OrdersTable
    with TableInfo<$OrdersTableTable, OrdersData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tidMeta = const VerificationMeta('tid');
  @override
  late final GeneratedColumn<int> tid = GeneratedColumn<int>(
      'tid', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pidMeta = const VerificationMeta('pid');
  @override
  late final GeneratedColumn<int> pid = GeneratedColumn<int>(
      'pid', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [tid, pid, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<OrdersData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tid')) {
      context.handle(
          _tidMeta, tid.isAcceptableOrUnknown(data['tid']!, _tidMeta));
    }
    if (data.containsKey('pid')) {
      context.handle(
          _pidMeta, pid.isAcceptableOrUnknown(data['pid']!, _pidMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tid};
  @override
  OrdersData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdersData(
      tid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tid']),
      pid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pid']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity']),
    );
  }

  @override
  $OrdersTableTable createAlias(String alias) {
    return $OrdersTableTable(attachedDatabase, alias);
  }
}

class OrdersData extends DataClass implements Insertable<OrdersData> {
  final int? tid;
  final int? pid;
  final int? quantity;
  const OrdersData({this.tid, this.pid, this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || tid != null) {
      map['tid'] = Variable<int>(tid);
    }
    if (!nullToAbsent || pid != null) {
      map['pid'] = Variable<int>(pid);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    return map;
  }

  OrdersTableCompanion toCompanion(bool nullToAbsent) {
    return OrdersTableCompanion(
      tid: tid == null && nullToAbsent ? const Value.absent() : Value(tid),
      pid: pid == null && nullToAbsent ? const Value.absent() : Value(pid),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
    );
  }

  factory OrdersData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdersData(
      tid: serializer.fromJson<int?>(json['tid']),
      pid: serializer.fromJson<int?>(json['pid']),
      quantity: serializer.fromJson<int?>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tid': serializer.toJson<int?>(tid),
      'pid': serializer.toJson<int?>(pid),
      'quantity': serializer.toJson<int?>(quantity),
    };
  }

  OrdersData copyWith(
          {Value<int?> tid = const Value.absent(),
          Value<int?> pid = const Value.absent(),
          Value<int?> quantity = const Value.absent()}) =>
      OrdersData(
        tid: tid.present ? tid.value : this.tid,
        pid: pid.present ? pid.value : this.pid,
        quantity: quantity.present ? quantity.value : this.quantity,
      );
  OrdersData copyWithCompanion(OrdersTableCompanion data) {
    return OrdersData(
      tid: data.tid.present ? data.tid.value : this.tid,
      pid: data.pid.present ? data.pid.value : this.pid,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdersData(')
          ..write('tid: $tid, ')
          ..write('pid: $pid, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tid, pid, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdersData &&
          other.tid == this.tid &&
          other.pid == this.pid &&
          other.quantity == this.quantity);
}

class OrdersTableCompanion extends UpdateCompanion<OrdersData> {
  final Value<int?> tid;
  final Value<int?> pid;
  final Value<int?> quantity;
  const OrdersTableCompanion({
    this.tid = const Value.absent(),
    this.pid = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  OrdersTableCompanion.insert({
    this.tid = const Value.absent(),
    this.pid = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  static Insertable<OrdersData> custom({
    Expression<int>? tid,
    Expression<int>? pid,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (tid != null) 'tid': tid,
      if (pid != null) 'pid': pid,
      if (quantity != null) 'quantity': quantity,
    });
  }

  OrdersTableCompanion copyWith(
      {Value<int?>? tid, Value<int?>? pid, Value<int?>? quantity}) {
    return OrdersTableCompanion(
      tid: tid ?? this.tid,
      pid: pid ?? this.pid,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tid.present) {
      map['tid'] = Variable<int>(tid.value);
    }
    if (pid.present) {
      map['pid'] = Variable<int>(pid.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersTableCompanion(')
          ..write('tid: $tid, ')
          ..write('pid: $pid, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductTableTable productTable = $ProductTableTable(this);
  late final $OrdersTableTable ordersTable = $OrdersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [productTable, ordersTable];
}

typedef $$ProductTableTableCreateCompanionBuilder = ProductTableCompanion
    Function({
  Value<int?> tid,
  required String productName,
  required String category,
  required double price,
  Value<int?> tax,
});
typedef $$ProductTableTableUpdateCompanionBuilder = ProductTableCompanion
    Function({
  Value<int?> tid,
  Value<String> productName,
  Value<String> category,
  Value<double> price,
  Value<int?> tax,
});

class $$ProductTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductTableTable,
    ProductData,
    $$ProductTableTableFilterComposer,
    $$ProductTableTableOrderingComposer,
    $$ProductTableTableCreateCompanionBuilder,
    $$ProductTableTableUpdateCompanionBuilder> {
  $$ProductTableTableTableManager(_$AppDatabase db, $ProductTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> tid = const Value.absent(),
            Value<String> productName = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<int?> tax = const Value.absent(),
          }) =>
              ProductTableCompanion(
            tid: tid,
            productName: productName,
            category: category,
            price: price,
            tax: tax,
          ),
          createCompanionCallback: ({
            Value<int?> tid = const Value.absent(),
            required String productName,
            required String category,
            required double price,
            Value<int?> tax = const Value.absent(),
          }) =>
              ProductTableCompanion.insert(
            tid: tid,
            productName: productName,
            category: category,
            price: price,
            tax: tax,
          ),
        ));
}

class $$ProductTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductTableTable> {
  $$ProductTableTableFilterComposer(super.$state);
  ColumnFilters<int> get tid => $state.composableBuilder(
      column: $state.table.tid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get productName => $state.composableBuilder(
      column: $state.table.productName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get price => $state.composableBuilder(
      column: $state.table.price,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get tax => $state.composableBuilder(
      column: $state.table.tax,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ProductTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductTableTable> {
  $$ProductTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get tid => $state.composableBuilder(
      column: $state.table.tid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get productName => $state.composableBuilder(
      column: $state.table.productName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get price => $state.composableBuilder(
      column: $state.table.price,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get tax => $state.composableBuilder(
      column: $state.table.tax,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$OrdersTableTableCreateCompanionBuilder = OrdersTableCompanion
    Function({
  Value<int?> tid,
  Value<int?> pid,
  Value<int?> quantity,
});
typedef $$OrdersTableTableUpdateCompanionBuilder = OrdersTableCompanion
    Function({
  Value<int?> tid,
  Value<int?> pid,
  Value<int?> quantity,
});

class $$OrdersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTableTable,
    OrdersData,
    $$OrdersTableTableFilterComposer,
    $$OrdersTableTableOrderingComposer,
    $$OrdersTableTableCreateCompanionBuilder,
    $$OrdersTableTableUpdateCompanionBuilder> {
  $$OrdersTableTableTableManager(_$AppDatabase db, $OrdersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$OrdersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$OrdersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> tid = const Value.absent(),
            Value<int?> pid = const Value.absent(),
            Value<int?> quantity = const Value.absent(),
          }) =>
              OrdersTableCompanion(
            tid: tid,
            pid: pid,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int?> tid = const Value.absent(),
            Value<int?> pid = const Value.absent(),
            Value<int?> quantity = const Value.absent(),
          }) =>
              OrdersTableCompanion.insert(
            tid: tid,
            pid: pid,
            quantity: quantity,
          ),
        ));
}

class $$OrdersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $OrdersTableTable> {
  $$OrdersTableTableFilterComposer(super.$state);
  ColumnFilters<int> get tid => $state.composableBuilder(
      column: $state.table.tid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get pid => $state.composableBuilder(
      column: $state.table.pid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$OrdersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $OrdersTableTable> {
  $$OrdersTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get tid => $state.composableBuilder(
      column: $state.table.tid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get pid => $state.composableBuilder(
      column: $state.table.pid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductTableTableTableManager get productTable =>
      $$ProductTableTableTableManager(_db, _db.productTable);
  $$OrdersTableTableTableManager get ordersTable =>
      $$OrdersTableTableTableManager(_db, _db.ordersTable);
}
