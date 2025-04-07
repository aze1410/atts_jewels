import 'package:atts_jewels/features/create_jewels/presentation/pages/create_product_page.dart';
import 'package:atts_jewels/features/product/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class EditJewelsPage extends StatelessWidget {
  const EditJewelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add and Edit Jewels')),
      body: const ProductListWidget(
        toShowFilterAndSort: false,
        toShowEditAndDelete: true,
      ), // Your list of products
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Create Product Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductCreationPage(),
            ),
          );
        },
        child: const Icon(Icons.add), // The + icon
        tooltip: 'Add Product',
      ),
    );
  }
}
