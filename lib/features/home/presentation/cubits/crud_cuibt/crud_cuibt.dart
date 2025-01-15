import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:iscad/features/home/domain/quantity_log/quantity_log.dart';
import 'package:iscad/features/home/presentation/cubits/crud_cuibt/crud_state.dart';
import 'package:iscad/features/home/domain/product_model/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final Box<Product> _productBox = Hive.box<Product>('productBox');

void addProduct(Product product) {
  try {
    if (_productBox.values.any((existingProduct) => existingProduct.id == product.id)) {
      emit(ProductError("Product with the same ID already exists."));
      return;
    }
    _productBox.put(product.id, product);
    emit(ProductAddedSuccess(product));
    fetchProducts();
  } catch (e) {
    emit(ProductError("Failed to add product: ${e.toString()}"));
  }
}

  void fetchProducts() {
    try {
      final products = _productBox.values.toList();
      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to fetch products: ${e.toString()}"));
    }
  }

  void modiyOfNewData({
    required String id,
    String? name,
    double? price,
    int? newQuantity,
  }) {
    if (state is! ProductListLoaded) {
      return;
    }

    final currentState = (state as ProductListLoaded).products;

    if (!currentState.any((product) => product.id == id)) {
      return;
    }

    final updatedState = currentState.map((product) {
      if (product.id == id) {
        return product.modify(
          quantity: newQuantity,
          name: name ?? product.name,
          price: price ?? product.price,
        );
      }
      return product;
    }).toList();

    emit(ProductListLoaded(updatedState));
  }

  void updateProduct(Product updatedProduct) {
    try {
      if (!_productBox.containsKey(updatedProduct.id)) {
        emit(ProductError("Product not found."));
        return;
      }
      _productBox.put(updatedProduct.id, updatedProduct);
      emit(ProductUpdatedSuccess(updatedProduct));
      fetchProducts();
    } catch (e) {
      emit(ProductError("Failed to update product: ${e.toString()}"));
    }
  }

  void deleteProduct(String productId) {
    try {
      if (!_productBox.containsKey(productId)) {
        emit(ProductError("Product not found."));
        return;
      }
      _productBox.delete(productId);
      emit(ProductDeletedSuccess(productId));
      fetchProducts();
    } catch (e) {
      emit(ProductError("Failed to delete product: ${e.toString()}"));
    }
  }

  void searchProducts(String query) {
    try {
      final allProducts = _productBox.values.toList();
      final filteredProducts = allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.id.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(ProductListLoaded(filteredProducts));
    } catch (e) {
      emit(ProductError("Failed to search products: ${e.toString()}"));
    }
  }

void updateProductQuantity(String productId, int newQuantity) {
  try {
    final product = _productBox.get(productId);

    if (product == null) {
      emit(ProductError("Product not found!"));
      return;
    }

    final currentQuantity = product.quantity;

    // Calculate sold quantity
    final soldQuantity = currentQuantity - newQuantity;
    if (soldQuantity < 0) {
      emit(ProductError("New quantity cannot exceed current quantity. Check the input."));
      return;
    }

    // Calculate total price for the sold quantity
    final totalPrice = soldQuantity * product.price;

    // Update the product in the product box
    final updatedProduct = Product(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: newQuantity,
    );
    _productBox.put(productId, updatedProduct);

    // Save the sale in the quantity history box
    final quantityHistoryBox = Hive.box<QuantityLog>('quantityLogBox');
    final logEntry = QuantityLog(
      productId: product.id,
      productName: product.name,
      soldQuantity: soldQuantity,
      timestamp: DateTime.now(),
      totalPrice: totalPrice,
    );
    quantityHistoryBox.add(logEntry);

    emit(ProductUpdated(updatedProduct));
  } catch (e) {
    emit(ProductError("Failed to update product: ${e.toString()}"));
  }
}

}
