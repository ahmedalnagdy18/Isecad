import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscad/invoicepage.dart';
import 'product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product: ${product.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text("ID: ${product.id}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Name: ${product.name}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Price: \$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Quantity in Stock: ${product.quantity}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: "Enter Quantity to Purchase",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final enteredQuantity = int.tryParse(quantityController.text);
                if (enteredQuantity != null && enteredQuantity > 0) {
                  if (enteredQuantity > product.quantity) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Insufficient stock!")),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvoicePage(
                          productName: product.name,
                          quantity: enteredQuantity,
                          price: product.price,
                        ),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid quantity!")),
                  );
                }
              },
              child: const Text("Generate Invoice"),
            ),
          ],
        ),
      ),
    );
  }
}
