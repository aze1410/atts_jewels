// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:drift/drift.dart';

// Define the Orders table
@DataClassName('OrdersData')
class OrdersTable extends Table {
  IntColumn get tid => integer().nullable().autoIncrement()(); // ID (Primary Key)
  IntColumn get pid => integer().nullable()(); 
  IntColumn get quantity => integer().nullable()();

  @override
  String get tableName => 'orders'; // Define the table name
}
