// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:drift/drift.dart';

// Define the product table
@DataClassName('ProductData')
class ProductTable extends Table {
  IntColumn get tid => integer().nullable().autoIncrement()(); // ID (Primary Key)
  TextColumn get productName => text().withLength(min: 1, max: 100)(); // Prxoduct Name
  TextColumn get category => text().withLength(min: 1, max: 50)(); // Category
  RealColumn get price => real()(); // Price
  IntColumn get tax => integer().nullable()(); // Tax Percentage

  @override
  String get tableName => 'product'; // Define the table name
}
