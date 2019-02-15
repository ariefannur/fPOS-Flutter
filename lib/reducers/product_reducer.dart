import 'package:redux/redux.dart';
import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/actions/action.dart';
import 'package:redux_exercise/models/transaction.dart';

final productReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, AddProductAction>(_addProduct),
  TypedReducer<List<Product>, DeleteProductAction>(_deleteProduct),
  TypedReducer<List<Product>, UpdateProductAction>(_updateProduct),
  TypedReducer<List<Product>, ProductLoadedAction>(_getAll),
   TypedReducer<List<Product>, SearchedProductAction>(_searchProduct),
  
]);

final transactionRecuder = combineReducers<List<TransactionData>>([
TypedReducer<List<TransactionData>, TransactionLoadedAction>(_addTransaction),
]);

final billRecuder = combineReducers<List<Bill>>([
TypedReducer<List<Bill>, BillLoadedAction>(_addBill),
]);

final queryReducer = combineReducers<String>([
  TypedReducer<String, SearchedProductAction>(_setQuery),
]);

final oneProductReducer = combineReducers<Product>([
 TypedReducer<Product, GetOneProductAction>(_getProduct),
]);

String _setQuery(String query, action) {
  return query;
}

List<Product> _addProduct(List<Product> products, AddProductAction action){
  return List.from(products)..add(action.product);
}

List<Product> _searchProduct(List<Product> products, SearchedProductAction action){
  return products.where((prod) => prod.name.contains(action.query)).toList();
}

Product _getProduct(Product product, GetOneProductAction action){
  return action.product;
}

List<TransactionData> _addTransaction(List<TransactionData> transaction, TransactionLoadedAction action){
  return List.from(transaction)..add(action.transaction[0]);
}

List<Bill> _addBill(List<Bill> bills, BillLoadedAction action){
  return List.from(bills)..add(action.bills[0]);
}

List<Product> _getAll(List<Product> products, ProductLoadedAction action){
  return action.products;
}


List<Product> _deleteProduct(List<Product> products, DeleteProductAction action){
  return products.where((product) => product.id != action.id).toList();
}

List<Product> _updateProduct(List<Product> products, UpdateProductAction action){
  return products.map((product) => product.id  == action.id ? action.product: product); 
}
