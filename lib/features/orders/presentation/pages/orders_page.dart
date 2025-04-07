
import 'package:atts_jewels/features/product/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: const ProductListWidget(
        isOrders: true,
        
      ), // Your list of products
    );
  }
}