import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iscad/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/printing.dart';

class InvoicePage extends StatefulWidget {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const InvoicePage({
    super.key,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  int? selectedQuantity;
  double total = 0.0;

  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
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
            Text("Product Name: ${widget.productName}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Quantity:", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                Flexible(
                  child: DropdownButton<int>(
                    value: selectedQuantity,
                    items: List.generate(widget.quantity, (index) => index + 1)
                        .map((number) => DropdownMenuItem<int>(
                              value: number,
                              child: Text(number.toString()),
                            ))
                        .toList(),
                    hint: const Text("Select quantity"),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value;
                        total = (selectedQuantity ?? 0) * widget.price;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Price per Unit: ${currencyFormatter.format(widget.price)}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Total Price: ${currencyFormatter.format(total)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Return to Products",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 14),
                ElevatedButton(
                  onPressed: selectedQuantity != null
                      ? () {
                          final remainingQuantity =
                              widget.quantity - (selectedQuantity ?? 0);

                          // Use the Cubit to update the product quantity
                          context
                              .read<ProductCubit>()
                              .updateProductQuantity(
                                  widget.productId, remainingQuantity);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Printing(
                                price: total,
                                productName: widget.productName,
                                quantity: selectedQuantity ?? 1,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
