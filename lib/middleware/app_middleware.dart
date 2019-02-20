import 'package:redux/redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/repository/data_repo.dart';
import 'package:redux_exercise/repository/local_repository.dart';
import 'package:redux_exercise/actions/action.dart';

var billId = 0;

List<Middleware<AppState>> createStoreMiddleware([
  DataRepository dataRepo = const LocalRepository()
]){

  final saveProduct = _createProduct(dataRepo);
  final loadProducts = _loadProducts(dataRepo);
  final searchProducts = _searchProduct(dataRepo);
  final getProduct = _getProduct(dataRepo);
  final saveTransaction = _saveTransaction(dataRepo);
  final saveBill = _saveBill(dataRepo);
  final getBills = _getBills(dataRepo);
  final getTransactions = _getTransactions(dataRepo);
  
  return[
    TypedMiddleware<AppState, AddProductAction>(saveProduct),
    TypedMiddleware<AppState, LoadProductAction>(loadProducts),
    TypedMiddleware<AppState, SearchProductAction>(searchProducts),
    TypedMiddleware<AppState, TransactionLoadedAction>(saveTransaction),
    TypedMiddleware<AppState, GetProductAction>(getProduct),
    TypedMiddleware<AppState, BillLoadedAction>(saveBill),
    TypedMiddleware<AppState, LoadBills>(getBills),
    TypedMiddleware<AppState, TransactionLoadedAction>(getTransactions),
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
    dataRepo.saveItemTransaction(store.state.transactions, store.state.idBill);
  };
}

Middleware<AppState> _saveBill(DataRepository dataRepo){
return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    var length =store.state.bills.length -1;
     dataRepo.saveBill(store.state.bills[length]).then( (id) {
        print("id bill "+id.toString());
        store.dispatch(InsertedIdBill(id));
     }
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

Middleware<AppState> _getBills(DataRepository dataRepo){
 return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.getBills().then(
      (bills){
        store.dispatch(BillLoadedAction(bills));
      }
    );
  };
}

Middleware<AppState> _getTransactions(DataRepository dataRepo){
 return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    
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