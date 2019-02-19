import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/models/transaction.dart';

abstract class DataRepository{

  Future<List<Product>> loadAllProducts();

  Future<List<Product>> searchProducts(String name);

  Future<Product> getProducts(String name);

  Future saveProduct(Product products);

  Future<int> saveBill(Bill bill);

  Future saveItemTransaction(List<TransactionData> data, int bill);
}