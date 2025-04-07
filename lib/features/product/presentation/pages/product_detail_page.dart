import 'package:atts_jewels/common/widgets/custom_dialogbox.dart';
import 'package:atts_jewels/features/create_jewels/presentation/providers/create_product_controller.dart';
import 'package:atts_jewels/features/create_jewels/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:atts_jewels/features/create_jewels/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int _quantity = 1; // Quantity of the product

  // Calculate the total price (Price + Tax) * Quantity
  double get _taxAmount {
    return widget.product.price * (widget.product.tax! / 100);
  }

  double get _totalPrice {
    double taxAmount = _taxAmount;
    return (widget.product.price + taxAmount) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/${widget.product.category}.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            // Product Name
            Text(
              widget.product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Product Category
            Text(
              widget.product.category,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Price and Tax
            _buildPriceTax(),

            // Quantity selector
            const SizedBox(height: 16),
            _buildQuantitySelector(),

            // Total Price
            const SizedBox(height: 16),
            _buildTotalPrice(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        text: 'Buy for  \$${_totalPrice.toStringAsFixed(2)}',
        onTap: () {
          showDialog(
            context: context, // Provide the context
            builder: (BuildContext context) {
              return CustomDialogBox(
                message: 'Are you sure you want to purchase this product?',
                onTap: () {
                  // Calling the save method from the provider
                  ref
                      .read(createProductControllerProvider.notifier)
                      .saveOrdersToDB(
                        id: widget.product.id ?? 0,
                        quantity: _quantity,
                      );
                  _generateInvoice();
                              Navigator.of(context)..pop()..pop();

                },
              );
            },
          );
        },
      ),
    );
  }

  // Widget to show price and tax
  Widget _buildPriceTax() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),

        // Tax (in percentage)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tax (in %)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.product.tax?.toStringAsFixed(2)}%',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  // Quantity selector
  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Minus Button with GestureDetector
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: _quantity > 1
                ? () {
                    setState(() {
                      _quantity--;
                    });
                  }
                : null,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.remove,
                size: 20,
              ),
            ),
          ),
        ),

        // Display Quantity Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            '$_quantity',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Plus Button with GestureDetector
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _quantity++;
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.add,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Total price including tax and quantity
  Widget _buildTotalPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Price',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$${_totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }

  // Generate Invoice and print or preview it
  Future<void> _generateInvoice() async {
    final pdf = pw.Document();
    final taxAmount = _taxAmount;
    final totalPrice = _totalPrice;

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Invoice',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Text('Product: ${widget.product.name}',
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('Category: ${widget.product.category}',
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('Price: \$${widget.product.price.toStringAsFixed(2)}',
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('Tax: ${widget.product.tax?.toStringAsFixed(2)}%',
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('Quantity: $_quantity',
                style: const pw.TextStyle(fontSize: 18)),
            pw.Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style:
                    pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Text('Thank you for your purchase!',
                style: const pw.TextStyle(fontSize: 16)),
          ],
        );
      },
    ));

    // Preview or print the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
