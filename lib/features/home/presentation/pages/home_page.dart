import 'package:atts_jewels/features/create_jewels/presentation/pages/edit_product_page.dart';
import 'package:atts_jewels/features/orders/presentation/pages/orders_page.dart';
import 'package:atts_jewels/features/product/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const AppDrawer(),
      body: const ProductListWidget(
        navigateDetailPage: true,
      ), // Your list of products
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'ATTS Jewels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
            ListTile(
            leading: const Icon(Icons.home), // Icon before "Add Product"
            title: const Text('Home'),
            onTap: () {
              // Navigate to the product creation page using normal navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add), // Icon before "Add Product"
            title: const Text('Add Product'),
            onTap: () {
              // Navigate to the product creation page using normal navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditJewelsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list), // Icon before "Orders"
            title: const Text('Orders'),
            onTap: () {
              // Navigate to the Orders page using normal navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
