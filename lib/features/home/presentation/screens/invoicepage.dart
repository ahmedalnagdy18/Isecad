import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iscad/core/observer/updater.dart';
import 'package:iscad/features/home/presentation/screens/printing.dart';
import 'package:iscad/generated/l10n.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).invoiceDetails,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text("${S.of(context).productName}: ${widget.productName}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(S.of(context).quantity,
                    style: const TextStyle(fontSize: 16)),
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
                    hint: Text(S.of(context).selectQuantity),
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
              "${S.of(context).pricePerUnit}: ${currencyFormatter.format(widget.price)}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "${S.of(context).totalPrice}: ${currencyFormatter.format(total)}",
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
                      backgroundColor: WidgetStatePropertyAll(
                    selectedQuantity != null ? Colors.green : Colors.grey,
                  )),
                  onPressed: selectedQuantity != null
                      ? () {
                          final remainingQuantity =
                              widget.quantity - (selectedQuantity ?? 0);

                          PostUpdater.instance.notifyLikeUpdate(
                              remainingQuantity, widget.productId);
                          Navigator.pushReplacement(
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
