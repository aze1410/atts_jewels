import 'dart:ffi';
import 'dart:io';
import 'package:atts_jewels/common/constants/app_constants.dart';
import 'package:atts_jewels/common/database/tables/orders_table.dart';
import 'package:atts_jewels/common/database/tables/products_table.dart';
import 'package:atts_jewels/features/create_jewels/domain/product_model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ProductTable, OrdersTable])
class AppDatabase extends _$AppDatabase {
  // Database constructor

  AppDatabase() : super(_openConnection());

  // Override the schema version (for migrations)
  @override
  int get schemaVersion => 1;

  // Define migrations to handle schema changes
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
      );

  // Open a database connection
  static QueryExecutor _openConnection() {
    // Use LazyDatabase to asynchronously find the right file location
    return LazyDatabase(() async {
      final path = await getApplicationDocumentsDirectory();
      final dbPath = p.join(
          path.path, AppConstant.productDBFileName); // Path to the DB file

      // Log the database path for debugging purposes
      if (kDebugMode) {
        print("Database path: $dbPath");
      }

      // Set up a background isolate for SQLCipher if needed
      return NativeDatabase.createInBackground(
        File(dbPath),
        logStatements: true, // Enable logging of SQL queries for debugging
        isolateSetup: () async {
          if (Platform.isAndroid) {
            try {
              // Ensure libsqlcipher.so is loaded for Android
              DynamicLibrary.open('libsqlcipher.so');
            } catch (e) {
              print("Error loading SQLCipher: $e");
            }
          }
        },
      );
    });
  }

  // DB METHODS
  Stream<List<Product>> getAllProducts({bool isOrders = false})  {

    // SQL query based on whether you want to get products with or without order information
    final query = isOrders
        ? '''
          SELECT p.*, o.quantity
          FROM product p
          INNER JOIN orders o ON o.pid = p.tid
        '''
        : 'SELECT * FROM product';


    // Map the query results to a list of Product objects
    return customSelect(
      query,
      readsFrom: {productTable, ordersTable},
    ).map((queryRow) {
      final productMap = queryRow.data;

      // Extract product data from the query result
      final product = Product(
        id: productMap['tid'] as int?,
        name: productMap['product_name'] ?? '' as String?,
        price: productMap['price'] ?? 0.0 as double?,
        category: productMap['category'] ?? '' as String?,
        tax: productMap['tax'] as int?,
      );

      // If it's from orders, adjust the price by multiplying with quantity
      final quantity = isOrders ? (productMap['quantity'] as int?) ?? 1 : 1;

      // Return a new Product object with the adjusted price
      return Product(
        id: product.id,
        name: product.name,
        price: (product.price ?? 0) * quantity, // Apply quantity to price
        category: product.category,
        tax: product.tax,
      );
    }).watch();

  }

  Future<void> deleteProduct(int id) {
    return (delete(productTable)..where((item) => item.tid.equals(id))).go();
  }
}
