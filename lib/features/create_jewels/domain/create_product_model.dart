class CreateProductState {
  final String productName;
  final String category;
  final double price;
  final int tax;
  final bool isLoading;
  final String? errorMessage;

  // Constructor with optional named parameters
  CreateProductState({
    required this.productName,
    required this.category,
    required this.price,
    required this.tax,
    this.isLoading = false,
    this.errorMessage,
  });

  // Create a copy of the state with modified values (for updating)
  CreateProductState copyWith({
    String? productName,
    String? category,
    double? price,
    int? tax,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CreateProductState(
      productName: productName ?? this.productName,
      category: category ?? this.category,
      price: price ?? this.price,
      tax: tax ?? this.tax,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
