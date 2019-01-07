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

  return[
    TypedMiddleware<AppState, AddProductAction>(saveProduct),
    TypedMiddleware<AppState, ProductLoadedAction>(loadProducts),
  ];
}

Middleware<AppState> _createProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.saveProduct(
        store.state.product
    );
  };
}

Middleware<AppState> _loadProducts(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.loadAllProducts();
  };
}