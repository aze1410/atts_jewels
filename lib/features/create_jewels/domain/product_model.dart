class Product {
  final int? id;  // Make id nullable
  final String name;
  final String category;
  final double price;
  final int? tax;  // Tax can be nullable

  Product({
    this.id,  // Allow id to be null during creation
    required this.name,
    required this.category,
    required this.price,
    this.tax,
  });

  // Convert from database row to Product model
  factory Product.fromDatabase(Map<String, dynamic> data) {
    return Product(
      id: data['tid'],  // Use 'tid' because that's the actual column name
      name: data['productName'],
      category: data['category'],
      price: data['price'],
      tax: data['tax'],
    );
  }

  // Convert Product model to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'tid': id,  // 'tid' is the actual column name
      'productName': name,
      'category': category,
      'price': price,
      'tax': tax,
    };
  }
}
