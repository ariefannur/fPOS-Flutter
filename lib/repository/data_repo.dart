import 'package:redux_exercise/models/product.dart';

abstract class DataRepository{

  Future<List<Product>> loadAllProducts();

  Future saveProduct(Product product);
}