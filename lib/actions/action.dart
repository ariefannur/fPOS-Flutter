import 'package:redux_exercise/models/product.dart';

class AddProductAction{
  final Product product;
  AddProductAction(this.product);
}

class DeleteProductAction{
  final int id;
  DeleteProductAction(this.id);
}

class UpdateProductAction{
   final int id;
  final Product product;
  UpdateProductAction(this.id, this.product);
}

class LoadProductAction {}

class SearchProductAction {}

class ProductLoadedAction{
  final List<Product> products;
  ProductLoadedAction(this.products);
}

class ProductNotLoadedAction{}

class SearchProduct{
  final String name;
  SearchProduct(this.name);
}