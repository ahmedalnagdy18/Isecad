import 'package:iscad/features/home/domain/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductListLoaded extends ProductState {
  final List<Product> products;
  ProductListLoaded(this.products);
}

class ProductAddedSuccess extends ProductState {
  final Product product;
  ProductAddedSuccess(this.product);
}

class ProductUpdatedSuccess extends ProductState {
  final Product product;
  ProductUpdatedSuccess(this.product);
}

class ProductDeletedSuccess extends ProductState {
  final String productId;
  ProductDeletedSuccess(this.productId);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductUpdated extends ProductState {
  final Product product;
  ProductUpdated(this.product);
}
