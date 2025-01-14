import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscad/generated/l10n.dart';

class EditProductDialog extends StatelessWidget {
  const EditProductDialog(
      {super.key,
      required this.elevatedButtononPressed,
      required this.textButtonOnPressed,
      required this.nameController,
      required this.priceController,
      required this.quantityController});
  final void Function() elevatedButtononPressed;
  final void Function() textButtonOnPressed;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).editProduct,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: S.of(context).productName,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: S.of(context).productPrice,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: S.of(context).productQuantity,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: textButtonOnPressed,
          child: Text(
            S.of(context).cancel,
          ),
        ),
        ElevatedButton(
          onPressed: elevatedButtononPressed,
          child: Text(
            S.of(context).save,
          ),
        ),
      ],
    );
  }
}
