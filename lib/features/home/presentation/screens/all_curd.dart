import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iscad/features/home/presentation/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/features/home/presentation/crud_cuibt/crud_state.dart';
import 'package:iscad/features/home/presentation/widgets/add_product_dialog.dart';
import 'package:iscad/features/home/presentation/widgets/all_card_body.dart';

import '../../domain/product_model.dart';

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

class _AllProductsView extends StatefulWidget {
  const _AllProductsView();

  @override
  State<_AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<_AllProductsView> {
  void _showAddProductDialog(BuildContext context) {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AddProductDialog(
          elevatedButtononPressed: () {
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
          textButtonOnPressed: () => Navigator.pop(dialogContext),
          idController: idController,
          nameController: nameController,
          priceController: priceController,
          quantityController: quantityController,
        );
      },
    );
  }

  int? newQuantity;

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "All Products",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
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

                  return AllCardBody(
                    products: products,
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
