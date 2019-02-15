import 'package:redux/redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/repository/data_repo.dart';
import 'package:redux_exercise/repository/local_repository.dart';
import 'package:redux_exercise/actions/action.dart';

List<Middleware<AppState>> createStoreMiddleware([
  DataRepository dataRepo = const LocalRepository()
]){

  final saveProduct = _createProduct(dataRepo);
  final loadProducts = _loadProducts(dataRepo);
  final searchProducts = _searchProduct(dataRepo);
  final getProduct = _getProduct(dataRepo);
  final saveTransaction = _saveTransaction(dataRepo);

  return[
    TypedMiddleware<AppState, AddProductAction>(saveProduct),
    TypedMiddleware<AppState, LoadProductAction>(loadProducts),
    TypedMiddleware<AppState, SearchProductAction>(searchProducts),
    TypedMiddleware<AppState, SaveTransactionAction>(saveTransaction),
    TypedMiddleware<AppState, GetProductAction>(getProduct),
  ];
}

Middleware<AppState> _createProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    final allProduct =  store.state.products;
  
    final product = allProduct[allProduct.length-1];
    print("save product qty : "+product.qty.toString()+" price : "+product.price.toString());
    dataRepo.saveProduct(
       product
    );
  };
}

Middleware<AppState> _saveTransaction(DataRepository dataRepo){
return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.saveItemTransaction(store.state.transactions, store.state.bills[0].id);
  };
}


Middleware<AppState> _loadProducts(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    
    dataRepo.loadAllProducts().then(
      (products){
        print("load product dispatch :: "+products.length.toString());
        store.dispatch(
          ProductLoadedAction(
              products
          )
        );
      }
    );
  };
}

Middleware<AppState> _searchProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    print("load product");
    dataRepo.searchProducts(store.state.query);
  };

}

Middleware<AppState> _getProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    print("get product");
    dataRepo.getProducts(store.state.query).then(
      (product){
        store.dispatch(
          GetOneProductAction(product)
        );
      }
    );
  };

}