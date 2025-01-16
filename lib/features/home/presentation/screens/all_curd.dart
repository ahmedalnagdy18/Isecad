import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iscad/core/colors/app_colors.dart';
import 'package:iscad/features/home/presentation/cubits/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/features/home/presentation/cubits/crud_cuibt/crud_state.dart';
import 'package:iscad/features/home/presentation/cubits/lang_cubit/locale_cubit.dart';
import 'package:iscad/features/home/presentation/widgets/add_product_dialog.dart';
import 'package:iscad/features/home/presentation/widgets/all_card_body.dart';
import 'package:iscad/features/home/presentation/screens/generate_excel.dart';
import 'package:iscad/generated/l10n.dart';

import '../../domain/product_model/product_model.dart';

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
        backgroundColor: AppColors.mainBlue,
        title: Text(
          S.of(context).allProducts,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.data_thresholding_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SalesReportPage(),
                      ));
                },
              ),
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
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: S.of(context).searchProducts,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
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
                        content: Text(
                            "${S.of(context).productAdded} ${state.product.name}")),
                  );
                } else if (state is ProductUpdatedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "${S.of(context).productUpdated} ${state.product.name}")),
                  );
                } else if (state is ProductDeletedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text(S.of(context).productDeletedSuccessfully)),
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
                    return Center(
                      child: Text(S.of(context).noProductsAvailable),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
              builder: (context, state) {
                String currentLanguage = state.locale.languageCode;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.language,
                      color: AppColors.mainBlue,
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      focusColor: Colors.white,
                      value: currentLanguage,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.mainBlue,
                      ),
                      underline: Container(),
                      items: ['ar', 'en'].map((String languageCode) {
                        return DropdownMenuItem<String>(
                          value: languageCode,
                          child: Text(
                            languageCode == 'ar'
                                ? S.of(context).dropdown1
                                : S.of(context).dropdown2,
                            style: TextStyle(
                              color: AppColors.mainBlue,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<LocaleCubit>().changeLanguage(newValue);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
