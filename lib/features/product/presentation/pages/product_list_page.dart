import 'package:atts_jewels/common/widgets/custom_dialogbox.dart';
import 'package:atts_jewels/features/create_jewels/presentation/pages/create_product_page.dart';
import 'package:atts_jewels/features/create_jewels/presentation/providers/create_product_controller.dart';
import 'package:atts_jewels/features/product/presentation/pages/product_detail_page.dart';
import 'package:atts_jewels/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atts_jewels/features/create_jewels/domain/product_model.dart';
import 'package:get_it/get_it.dart';
import 'package:atts_jewels/common/database/app_database.dart';

class ProductListWidget extends ConsumerStatefulWidget {
  final bool isOrders;
  final bool navigateDetailPage;
  final bool toShowFilterAndSort;
  final bool toShowEditAndDelete;

  const ProductListWidget({
    Key? key,
    this.isOrders = false,
    this.navigateDetailPage = false,
    this.toShowFilterAndSort = true,
    this.toShowEditAndDelete = false,
  }) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends ConsumerState<ProductListWidget> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedCategories = [];
  String _sortBy = 'Name';

  @override
  Widget build(BuildContext context) {
    // final productAsyncValue = ref.watch(productProvider);
    final productAsyncValue = ref.watch(productProvider(widget.isOrders));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          if (widget.toShowFilterAndSort)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Filter and Sort Row (Tapping on it opens bottom sheet)
          if (widget.toShowFilterAndSort)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // Filter Row (Tap to show bottom sheet)
                    _buildFilterSortOption(
                      icon: Icons.filter_alt_outlined,
                      label: 'Filter',
                      onTap: () => _showFilterBottomSheet(context),
                    ),

                    // Sort Row (Tap to show bottom sheet)
                    _buildFilterSortOption(
                      icon: Icons.sort,
                      label: 'Sort by',
                      onTap: () => _showSortBottomSheet(context),
                    ),
                  ],
                ),
              ),
            ),

          // Displaying Products
          Expanded(
            child: productAsyncValue.when(
              data: (products) {
                // Filter products based on search query and selected categories
                List<Product> filteredProducts = products.where((product) {
                  final matchesSearch = product.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase());
                  final matchesCategory = _selectedCategories.isEmpty ||
                      _selectedCategories.contains(product.category);
                  return matchesSearch && matchesCategory;
                }).toList();

                // Sort products based on selected field
                if (_sortBy == 'Price') {
                  filteredProducts.sort((a, b) => a.price.compareTo(b.price));
                } else if (_sortBy == 'Name') {
                  filteredProducts.sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                }

                // Check if no products match the filter
                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Text(
                      'No products available here',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Display filtered and sorted products in a ListView
                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        if (widget.navigateDetailPage) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product, // Pass the product here
                              ),
                            ),
                          );
                        }
                      },
                      child: ProductCard(
                        product: product,
                        toShowEditAndDelete: widget.toShowEditAndDelete,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductCreationPage(
                                  product:
                                      product), // Pass the product to the edit page
                            ),
                          );
                        },
                        onDelete: () {
                          showDialog(
                            context: context, // Provide the context
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                message:
                                    'Are you sure you want to delete this product?',
                                onTap: () {
                                  ref
                                      .read(createProductControllerProvider
                                          .notifier)
                                      .deleteProduct(product.id ?? 0);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog after deleting
                                },
                              );
                            },
                          );

                          // Optionally, show a success message or reload the list of products after deletion
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Filter/Sort Option Card
  Widget _buildFilterSortOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey.shade800),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade800),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Bottom Sheet for Filter with checkboxes
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildFilterOption('Earrings'),
              _buildFilterOption('Necklace'),
              _buildFilterOption('Ring'),
              _buildFilterOption('Bracelet'),
              _buildFilterOption('Watch'),
            ],
          ),
        );
      },
    );
  }

// Build each filter option with checkbox
  Widget _buildFilterOption(String category) {
    return CheckboxListTile(
      title: Text(category),
      value: _selectedCategories.contains(category), // Correct value
      onChanged: (bool? selected) {
        Navigator.of(context).pop();
        setState(() {
          if (selected == true) {
            // Add category to the list when selected
            _selectedCategories.add(category);
          } else {
            // Remove category from the list when deselected
            _selectedCategories.remove(category);
          }
        });
      },
    );
  }

  // Show Bottom Sheet for Sort with radio buttons
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSortOption('Name'),
              _buildSortOption('Price'),
            ],
          ),
        );
      },
    );
  }

  // Build each sort option with radio button
  Widget _buildSortOption(String option) {
    return RadioListTile<String>(
      title: Text(option),
      value: option,
      groupValue: _sortBy,
      onChanged: (String? selected) {
        setState(() {
          _sortBy = selected!;
        });
        Navigator.pop(context); // Close the bottom sheet
      },
    );
  }
}

final productProvider =
    StreamProvider.family<List<Product>, bool>((ref, isOrders) {
  final db = GetIt.I.get<AppDatabase>();
  return db.getAllProducts(isOrders: isOrders);
});
