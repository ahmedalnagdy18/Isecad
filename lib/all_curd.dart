import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iscad/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/crud_cuibt/crud_state.dart';
import 'package:iscad/printing.dart';
import 'product_model.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..fetchProducts(),
      child: const _AllProductsView(),
    );
  }
}

class _AllProductsView extends StatelessWidget {
  const _AllProductsView();

  void _showAddProductDialog(BuildContext context) {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
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
                  decoration:
                      const InputDecoration(labelText: "Product Quantity"),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final id = idController.text.trim();
                final name = nameController.text.trim();
                final price = double.tryParse(priceController.text);
                final quantity = int.tryParse(quantityController.text);

                if (id.isEmpty ||
                    name.isEmpty ||
                    price == null ||
                    quantity == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please fill all fields correctly!")),
                  );
                  return;
                }

                final product = Product(
                  id: id,
                  name: name,
                  price: price,
                  quantity: quantity,
                );

                context.read<ProductCubit>().addProduct(product);
                Navigator.pop(dialogContext);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);
    final priceController =
        TextEditingController(text: product.price.toString());
    final quantityController =
        TextEditingController(text: product.quantity.toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Edit Product"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration:
                      const InputDecoration(labelText: "Product Quantity"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
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
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddProductDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search Products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                context.read<ProductCubit>().searchProducts(query);
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is ProductAddedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Product added: ${state.product.name}")),
                  );
                } else if (state is ProductUpdatedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Product updated: ${state.product.name}")),
                  );
                } else if (state is ProductDeletedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Product deleted successfully.")),
                  );
                } else if (state is ProductError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProductListLoaded) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return const Center(
                      child: Text("No products available."),
                    );
                  }

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Printing(products: product),
                              settings: RouteSettings(arguments: [
                                product.name,
                                product.price.toString(),
                                product.quantity.toString(),
                                product.id
                              ]),
                            ),
                          );
                          //   print("===== ${products[index].name}");
                        },
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                              "Price: \$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditProductDialog(context, product);
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
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
