import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iscad/core/observer/observer.dart';
import 'package:iscad/features/home/domain/product_model.dart';
import 'package:iscad/features/home/presentation/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/features/home/presentation/crud_cuibt/crud_state.dart';
import 'package:iscad/features/home/presentation/screens/invoicepage.dart';
import 'package:iscad/features/home/presentation/widgets/edit_product_dialog.dart';

class AllCardBody extends StatefulWidget {
  const AllCardBody({super.key, required this.products});
  final List<Product> products;
  @override
  State<AllCardBody> createState() => _AllCardBodyState();
}

class _AllCardBodyState extends State<AllCardBody> {
  bool? isLongpress;

  int? newQuantity;

  final Set<String> selectedProductIds = {};
  late PostObserver postObserver;

  @override
  void initState() {
    super.initState();

    postObserver = PostObserver(
      updatequntity: (updatedQuantity, id) {
        if (widget.products.any((product) => product.id == id)) {
          setState(() {
            context
                .read<ProductCubit>()
                .modiyOfNewData(newQuantity: updatedQuantity, id: id);
            newQuantity = updatedQuantity;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    postObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLongpress == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      shape: Border.all(color: Colors.black),
                      onPressed: () {
                        isLongpress = false;
                        selectedProductIds.clear();
                        setState(() {});
                      },
                      color: Colors.white,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (selectedProductIds.isNotEmpty) {
                          final selectedProducts = widget.products
                              .where((product) =>
                                  selectedProductIds.contains(product.id))
                              .toList();

                          for (final product in selectedProducts) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvoicePage(
                                  price: product.price,
                                  productName: product.name,
                                  quantity: product.quantity,
                                  productId: product.id,
                                ),
                                settings: RouteSettings(arguments: [
                                  product.name,
                                  product.price.toString(),
                                  product.quantity.toString(),
                                  product.id,
                                ]),
                              ),
                            );
                          }
                        }
                      },
                      color: selectedProductIds.isEmpty
                          ? Colors.grey
                          : Colors.black,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        Expanded(
          child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              final bool isSelected = selectedProductIds.contains(product.id);
              return InkWell(
                onLongPress: () {
                  isLongpress = true;
                  setState(() {});
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoicePage(
                        price: product.price,
                        productName: product.name,
                        quantity: product.quantity,
                        productId: product.id,
                      ),
                      settings: RouteSettings(arguments: [
                        product.name,
                        product.price.toString(),
                        product.quantity.toString(),
                        product.id
                      ]),
                    ),
                  );
                },
                child: Row(
                  children: [
                    isLongpress == true
                        ? Checkbox(
                            fillColor:
                                const WidgetStatePropertyAll(Colors.white),
                            side: const BorderSide(color: Colors.black),
                            checkColor: Colors.black,
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  selectedProductIds.add(product.id);
                                } else {
                                  selectedProductIds.remove(product.id);
                                }
                              });
                            },
                          )
                        : const SizedBox(),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          product.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            if (state is ProductListLoaded) {
                              final updatedProduct = state.products
                                  .firstWhere((p) => p.id == product.id);
                              return Text(
                                  "Price: \$${updatedProduct.price.toStringAsFixed(2)} | Quantity: ${updatedProduct.quantity}");
                            }
                            return Text(
                                "Price: \$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}");
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showEditProductDialog(context, product);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<ProductCubit>()
                                    .deleteProduct(product.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void showEditProductDialog(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);

    final priceController =
        TextEditingController(text: product.price.toString());

    final quantityController =
        TextEditingController(text: product.quantity.toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return EditProductDialog(
          elevatedButtononPressed: () {
            final name = nameController.text.trim();
            final price = double.tryParse(priceController.text);
            final quantity = int.tryParse(quantityController.text);

            if (name.isEmpty || price == null || quantity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Please fill all fields correctly!")),
              );
              return;
            }

            final updatedProduct = Product(
              id: product.id,
              name: name,
              price: price,
              quantity: quantity,
            );

            context.read<ProductCubit>().updateProduct(updatedProduct);
            Navigator.pop(dialogContext);
          },
          textButtonOnPressed: () => Navigator.pop(dialogContext),
          nameController: nameController,
          priceController: priceController,
          quantityController: quantityController,
        );
      },
    );
  }
}
