import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/models/transaction.dart';

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

class GetProductAction {
  final String query;
  GetProductAction({this.query});
}

class QueryAction{
  
}

class GetOneProductAction {
  final Product product;
  GetOneProductAction(this.product);
}

class SearchedProductAction {
  final String query;
  SearchedProductAction(this.query);
}

class SaveTransactionAction {}

class ProductLoadedAction{
  final List<Product> products;
  ProductLoadedAction(this.products);
}

class BillLoadedAction{
  final List<Bill> bills;
  BillLoadedAction(this.bills);
}

class TransactionLoadedAction{
  final List<TransactionData> transaction;
  TransactionLoadedAction(this.transaction);
}

class ProductNotLoadedAction{}

class SearchProduct{
  final String name;
  SearchProduct(this.name);
}