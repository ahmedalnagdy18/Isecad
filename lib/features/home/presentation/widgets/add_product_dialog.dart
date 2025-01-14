import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductDialog extends StatelessWidget {
  const AddProductDialog(
      {super.key,
      required this.elevatedButtononPressed,
      required this.textButtonOnPressed,
      required this.idController,
      required this.nameController,
      required this.priceController,
      required this.quantityController});
  final void Function() elevatedButtononPressed;
  final void Function() textButtonOnPressed;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "Product ID"),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Product Price"),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Product Quantity"),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: textButtonOnPressed,
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: elevatedButtononPressed,
          child: const Text("Add"),
        ),
      ],
    );
  }
}
