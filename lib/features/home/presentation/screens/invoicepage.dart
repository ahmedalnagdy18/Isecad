import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iscad/core/observer/updater.dart';
import 'package:iscad/features/home/domain/product_model/product_model.dart';
import 'package:iscad/features/home/presentation/cubits/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/features/home/presentation/screens/printing.dart';
import 'package:iscad/generated/l10n.dart';

class InvoicePage extends StatefulWidget {
  final List<Product> products;

  const InvoicePage({
    super.key,
    required this.products,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final Map<int, int?> selectedQuantities = {};
  final Map<int, double> totals = {};

  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    // Initialize selectedQuantities with null values for all products
    for (var i = 0; i < widget.products.length; i++) {
      selectedQuantities[i] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          S.of(context).invoice,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).invoiceDetails,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 18),
                itemCount: widget.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  final selectedQuantity = selectedQuantities[index];
                  final total = totals[index] ?? 0.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${S.of(context).productName}: ${product.name}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(S.of(context).quantity,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 120,
                            child: DropdownButton<int>(
                              value: selectedQuantity,
                              items: List.generate(
                                      product.quantity, (index) => index + 1)
                                  .map((number) => DropdownMenuItem<int>(
                                        value: number,
                                        child: Text(number.toString()),
                                      ))
                                  .toList(),
                              hint: Text(
                                S.of(context).selectQuantity,
                                style: const TextStyle(fontSize: 12),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedQuantities[index] = value;
                                  totals[index] = (value ?? 0) * product.price;
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${S.of(context).pricePerUnit}: ${currencyFormatter.format(product.price)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "${S.of(context).totalPrice}: ${currencyFormatter.format(total)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).returnToProducts,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 14),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      selectedQuantities.values.every((q) => q != null)
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  onPressed: selectedQuantities.values.every((q) => q != null)
                      ? () {
                          selectedQuantities.forEach((index, selectedQuantity) {
                            if (selectedQuantity != null) {
                              final product = widget.products[index];
                              final remainingQuantity =
                                  product.quantity - selectedQuantity;

                              if (remainingQuantity >= 0) {
                                // Notify the quantity update
                                QuntityUpdater.instance.notifyQuntityUpdate(
                                  remainingQuantity,
                                  product.id,
                                );

                                // Save the updated quantity in Hive
                                BlocProvider.of<ProductCubit>(context).updateProductQuantity(
                                  product.id,
                                  remainingQuantity,
                                );
                              }
                            }
                          });
                          // Navigate to the Printing page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Printing(
                                products: widget.products,
                                selectedQuantities: selectedQuantities,
                                totals: totals,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    S.of(context).save,
                    style: const TextStyle(color: Colors.white),
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
