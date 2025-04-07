import 'package:atts_jewels/common/widgets/custom_dialogbox.dart';
import 'package:atts_jewels/features/create_jewels/domain/product_model.dart';
import 'package:atts_jewels/features/create_jewels/presentation/providers/create_product_controller.dart';
import 'package:atts_jewels/features/create_jewels/presentation/widgets/custom_button.dart';
import 'package:atts_jewels/features/create_jewels/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atts_jewels/features/create_jewels/domain/create_product_model.dart';

class ProductCreationPage extends ConsumerStatefulWidget {
  final Product? product; // Nullable product for editing

  const ProductCreationPage({super.key, this.product});

  @override
  _ProductCreationPageState createState() => _ProductCreationPageState();
}

class _ProductCreationPageState extends ConsumerState<ProductCreationPage> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _taxController = TextEditingController();

  String _selectedCategory = 'Earrings';

  final List<String> categories = [
    'Earrings',
    'Necklace',
    'Bracelet',
    'Ring',
    'Watch',
  ];

  @override
  void initState() {
    super.initState();

    // If editing, populate the fields with existing product data
    if (widget.product != null) {
      _productNameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _taxController.text = widget.product!.tax.toString();
      _selectedCategory = widget.product!.category;
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when done
    _productNameController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }
void _submitProduct() {
  final String productName = _productNameController.text;
  final double price = double.tryParse(_priceController.text) ?? 0.0;
  final int tax = int.tryParse(_taxController.text) ?? 0;

  if (productName.isNotEmpty && price > 0) {
    // Show confirmation dialog before proceeding
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          message: widget.product == null
              ? 'Are you sure you want to create this product?'
              : 'Are you sure you want to edit this product?',
          onTap: () {
            // Proceed with creating or editing the product
            final productState = CreateProductState(
              productName: productName,
              category: _selectedCategory,
              price: price,
              tax: tax,
            );

            ref
                .read(createProductControllerProvider.notifier)
                .updateField(productState);

            if (widget.product == null) {
              // Create a new product
              ref.read(createProductControllerProvider.notifier).saveProductToDB();
            } else {
              // Edit an existing product
              ref
                  .read(createProductControllerProvider.notifier)
                  .editProduct(widget.product!.id ?? 0);
            }

            Navigator.of(context)..pop()..pop(); // Close the dialog after the action
          },
        );
      },
    );
  } else {
    // Handle validation error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill out all fields correctly!')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final createProductState = ref.watch(createProductControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Create Product' : 'Edit Product'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Name
              CustomTextField(
                controller: _productNameController,
                label: 'Product Name',
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              // Category Selection
              CustomDropdown(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: categories,
              ),
              const SizedBox(height: 16),

              // Product Price
              CustomTextField(
                controller: _priceController,
                label: 'Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Tax for the Product
              CustomTextField(
                controller: _taxController,
                label: 'Tax (%)',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        text: createProductState.isLoading
            ? (widget.product == null ? 'Creating...' : 'Editing...')
            : (widget.product == null ? 'Create Product' : 'Save Changes'),
        onTap: _submitProduct,
      ),
    );
  }
}
