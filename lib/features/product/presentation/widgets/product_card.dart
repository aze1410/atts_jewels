import 'package:flutter/material.dart';
import 'package:atts_jewels/features/create_jewels/domain/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool toShowEditAndDelete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    Key? key,
    required this.product,
    this.quantity = 1,
    this.toShowEditAndDelete = false,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/${product.category}.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Category
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Specs
                  // _buildSpecRow('Caret:', product.caret ?? '', bold: true),
                  // _buildSpecRow('Size:', product.size ?? '', bold: true),
                  // _buildSpecRow('Color:', product.color ?? '', bold: false),
                  const SizedBox(height: 4),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),
                  if (toShowEditAndDelete)
                    Row(
                      children: [
                        const Spacer(),
                        // Edit icon
                        GestureDetector(
                          onTap: onEdit,
                          child: const Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Delete icon
                        GestureDetector(
                          onTap: onDelete,
                          child: const Icon(Icons.delete_outline),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 18),
        ),
      ),
    );
  }
}
