import 'package:atts_jewels/features/create_jewels/domain/create_product_model.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:atts_jewels/common/database/app_database.dart'; // For DB access

part 'create_product_controller.g.dart';

@riverpod
class CreateProductController extends _$CreateProductController {
  // Initial state of the form
  @override
  CreateProductState build() {
    return CreateProductState(
      productName: '',
      category: 'Earrings', // Default category
      price: 0.0,
      tax: 0,
    );
  }

  // Unified update method that accepts a Product model
  void updateField(CreateProductState productState) {
    state = state.copyWith(
      productName: productState.productName,
      category: productState.category,
      price: productState.price,
      tax: productState.tax,
    );
  }

  // Save Product to the database
  Future<void> saveProductToDB() async {
    try {
      // Change the state to loading
      state = state.copyWith(isLoading: true);
      final db = GetIt.I.get<AppDatabase>(); // Access the database via GetIt
      // Save the product to the database
      await db.into(db.productTable).insert(
            ProductTableCompanion(
              productName: Value(state.productName),
              category: Value(state.category),
              price: Value(state.price),
              tax: Value(state.tax),
            ),
          );

      // Successfully saved, update state
      state = state.copyWith(isLoading: false);
    } catch (e) {
      // Handle errors and set the error message in the state
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to save product: $e',
      );
      print(e);
    }
  }

  // Save Product to the database
  Future<void> saveOrdersToDB({
    required int id,
    required int quantity,
  }) async {
    try {
      final db = GetIt.I.get<AppDatabase>(); // Access the database via GetIt
      // Save the Orders to the database
      await db.into(db.ordersTable).insert(
            OrdersTableCompanion(
              pid: Value(id),
              quantity: Value(quantity),
            ),
          );
    } catch (e) {
      print(e);
    }
  }

  Future<void> editProduct(int tid) async {
    try {
      state = state.copyWith(isLoading: true);
      final db = GetIt.I.get<AppDatabase>();

      // Update the product in the database where tid matches the given tid
      await db.update(db.productTable).replace(
            ProductTableCompanion(
              tid: Value(tid),
              productName: Value(state.productName),
              category: Value(state.category),
              price: Value(state.price),
              tax: Value(state.tax),
            ),
          ); // Correct where syntax to match product by tid

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update product: $e',
      );
      print(e);
    }
  }

  // Delete a Product with a specific tid
  Future<void> deleteProduct(int tid) async {
    try {
      final db = GetIt.I.get<AppDatabase>();
      return db.deleteProduct(tid); // Returns a stream of products
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }
}
