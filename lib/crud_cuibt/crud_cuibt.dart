import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:iscad/crud_cuibt/crud_state.dart';
import 'package:iscad/product_model.dart';


class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final Box<Product> _productBox = Hive.box<Product>('productBox');


  void addProduct(Product product) {
    try {
      if (_productBox.containsKey(product.id)) {
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

}

