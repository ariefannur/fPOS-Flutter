import 'package:redux/redux.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/actions/action.dart';

final productReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, AddProductAction>(_addProduct),
  TypedReducer<List<Product>, DeleteProductAction>(_deleteProduct),
  TypedReducer<List<Product>, UpdateProductAction>(_updateProduct),
  TypedReducer<List<Product>, ProductLoadedAction>(_getAll),
]);

List<Product> _addProduct(List<Product> products, AddProductAction action){
  return List.from(products)..add(action.product);
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
