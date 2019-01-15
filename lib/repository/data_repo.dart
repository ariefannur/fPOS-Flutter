import 'package:redux_exercise/models/product.dart';

abstract class DataRepository{

  Future<List<Product>> loadAllProducts();

  Future<List<Product>> searchProducts(String name);

  Future saveProduct(List<Product> products);
}