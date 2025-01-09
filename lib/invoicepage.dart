import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final String productName;
  final int quantity;
  final double price;

  const InvoicePage({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final double total = quantity * price;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invoice Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text("Product Name: $productName", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Quantity: $quantity", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Price per Unit: \$${price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              "Total Price: \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the product list
                  Navigator.pop(context);
                },
                child: const Text("Return to Products"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
