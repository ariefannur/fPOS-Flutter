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

  return[
    TypedMiddleware<AppState, AddProductAction>(saveProduct),
    TypedMiddleware<AppState, LoadProductAction>(loadProducts),
    TypedMiddleware<AppState, SearchProductAction>(searchProducts),
  ];
}

Middleware<AppState> _createProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    final productList =  store.state.products;
    final product = productList[productList.length-1];
    print("save product qty : "+product.qty.toString()+" price : "+product.price.toString());
    dataRepo.saveProduct(
       productList
    );
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
    dataRepo.searchProducts("a");
  };
}